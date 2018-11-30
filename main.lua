-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local json = require "json"
local physics = require "physics"
local data = require "data"

display.setStatusBar( display.HiddenStatusBar )
-- display.setDefault( "background", 1, 1, 1 )

physics.start()
physics.setGravity(0, 0)
-- physics.setDrawMode("hybrid")
-- physics.setContinuous(true)

-----------------------------------------------------------------------------------------
--
-- variables setup
--
-----------------------------------------------------------------------------------------
local W = display.contentWidth
local H = display.contentHeight
local actualW = display.actualContentWidth
local actualH = display.actualContentHeight

local wDiff = (actualW-W)/2
local hDiff = (actualH-H)/2

local xCenter = display.contentCenterX
local yCenter = display.contentCenterY

local background = display.newRect(xCenter, yCenter, actualW, actualH);
background:setFillColor(1, 1, 1)

-- Board entities
local center
local marbles = {}
local vertices = {}
local border

-- Striker
local aimCircles = {}
local striker
local strikerCollisionCount = 0
local isStrikeInProgress = false

-- All physics body


-- Sound
-- local stretchSound = audio.loadSound("sound/stretch.wav")
local collisionSound = audio.loadSound( "sound/collision.wav" )

-- Text message
local message
local levelMessage

-- Other collision body
local otherCollisionBody

-- Game
local isGameStarted = false
local level

--Draw
local isDrawInProgress = false

-- Group
local rootGroup

-- Tabs
local tabBar

-- Level Navigation
local delta = 25
local navGroup = display.newGroup()
local navLeft
local navRight
local navToggle = false

-- Level Browser
local browseLevel
local browseRect

-- History implementation
local historyTable = {}
local filePath = system.pathForFile( "history.json", system.DocumentsDirectory )

-----------------------------------------------------------------------------------------
--
-- History implementation
--
-----------------------------------------------------------------------------------------

-- Load History
local function loadHistory()
    
    local file = io.open( filePath, "r" )
    
    if file then
        local contents = file:read( "*a" )
        io.close( file )
        historyTable = json.decode( contents )
        level = historyTable.currentLevel
        print("History Table", json.prettify(historyTable))
    end
    
    if ( historyTable.currentLevel == nil) then
        historyTable = { 
            currentLevel=1
        }
        level = historyTable.currentLevel
    end
    print("loadHistory", json.prettify(historyTable))
end

-- Save History
local function saveHistory()
    print("saveHistory", json.prettify(historyTable))
    -- for i = #historyTable, 11, -1 do
    --     table.remove( historyTable, i )
    -- end
 
    local file = io.open( filePath, "w" )
 
    if file then
        file:write( json.encode( historyTable ) )
        io.close( file )
    end
end

-----------------------------------------------------------------------------------------
--
-- Util
--
-----------------------------------------------------------------------------------------
local function emptyTable( data )
    for i=#data, 1, -1 do
        table.remove( data, i)
    end
end

-- Display message
local function displayMessage( msg )
    message.text = msg
    transition.to(message, {time=500, y=yCenter/4, transition=easing.outBounce})
    transition.to(message.fill, {time=500, a=1, transition=easing.inExpo, onComplete=function ()
        transition.to(message.fill, {time=1000, a=0, transition=easing.outBounce, onComplete=function ()
            transition.to(message, {time=1000, y=-88})
        end})
    end})
end

-- Signal Error
local function signalCollisionError( msg )
    
    transition.to(border.fill, {
        time=500,
        iterations=2,
        transition=easing.inOutSine,
        onComplete = function ( self )
            if(border._properties ~= nil) then
                border:setFillColor(1,1,1,0)
                displayMessage(msg)
            end
        end,
        r=1, g=0, b=1, a=0.5
    })
end

-- Toggle Nav
local function toggleNav()
    navToggle = not navToggle
    if(navToggle) then
        transition.to(navLeft, {time=1000, y=H+hDiff/2 + 5, transition=easing.outBounce})
        transition.to(navRight, {time=1000, y=H+hDiff/2 + 5, transition=easing.outBounce})
        transition.to(browseLevel, {time=1000, y=H+hDiff/2 + 5, transition=easing.outBounce})
        
    else
        transition.to(navLeft, {time=1000, y=actualH, transition=easing.outBounce})
        transition.to(navRight, {time=1000, y=actualH, transition=easing.outBounce})
        transition.to(browseLevel, {time=1000, y=actualH, transition=easing.outBounce})
    end
end
-----------------------------------------------------------------------------------------
--
-- draw board
--
-----------------------------------------------------------------------------------------

-- Draw center
local function drawCenter(data, level)
    center = display.newCircle(rootGroup, data[level].center.x, data[level].center.y, data[level].center.r)
    center:setFillColor(unpack(data[level].center.color))
    physics.addBody(center, "dynamic", {radius=data[level].center.r, firction=0.3, bounce=0.3})
    center.linearDamping = 0.5
    center.name = "center"
end

-- Draw lines
local function drawLines( data, level )
    for i = 1, #data[level].marbles do
        local line = display.newLine(
            rootGroup,
            data[level].center.x,
            data[level].center.y,
            data[level].center.x + data[level].marbles[i].x,
            data[level].center.y + data[level].marbles[i].y
        )
        line:setStrokeColor( unpack(data[level].edge.lineStrokeColor) )
        line.strokeWidth = data[level].edge.lineStrokeWidth
    end
end

-- Draw board border
local function drawBorder( data, level )
    for i = 1, #data[level].marbles do
        table.insert(vertices, data[level].center.x + data[level].marbles[i].x)
        table.insert(vertices, data[level].center.y + data[level].marbles[i].y)
    end
    
    border = display.newPolygon( rootGroup, data[level].center.x, data[level].center.y, vertices )
    border:setFillColor(unpack(data[level].edge.borderFillColor))
    border.strokeWidth = data[level].edge.borderStrokeWidth
    border:setStrokeColor( unpack(data[level].edge.borderStrokeColor) )
    border.name = "border"

    physics.addBody(border, "static", {isSensor=true})
end

-- Draw marbles
local function drawMarbles(data, level)
    -- drawBorder(data, level)

    for i = 1, #data[level].marbles do
        local circle = display.newCircle(rootGroup, data[level].center.x + data[level].marbles[i].x, 
            data[level].center.y + data[level].marbles[i].y, data[level].marbles[i].r)
        circle:setFillColor(unpack(data[level].marbles[i].color))
        table.insert(marbles, circle)
        physics.addBody(circle, "dynamic", {radius=data[level].marbles[i].r, friction=0.3, bounce=0.3})
        circle.linearDamping = 0.5
        circle.name = "marble"
        circle.id = i
        table.insert(vertices, data[level].center.x + data[level].marbles[i].x)
        table.insert(vertices, data[level].center.y + data[level].marbles[i].y)
    end
end

-- Draw board edges
local function drawBoardEdges()
    local left = display.newRect(0, H/2, 1, actualH)
    left:setFillColor(1,0,0)
    physics.addBody(left, "static", {firction=0.3, bounce=0.3})
    left.name = "edge"

    local right = display.newRect(W, H/2, 1, actualH)
    right:setFillColor(1,0,0)
    physics.addBody(right, "static", {firction=0.3, bounce=0.3})
    right.name = "edge"

    local top = display.newRect(W/2, -(actualH - H)/2, W, 1)
    top:setFillColor(1,0,0)
    physics.addBody(top, "static", {firction=0.3, bounce=0.3})
    top.name = "edge"

    local bottom = display.newRect(W/2, H + (actualH - H)/2, W, 1)
    bottom:setFillColor(1,0,0)
    physics.addBody(bottom, "static", {firction=0.3, bounce=0.3})
    bottom.name = "edge"
end

local function drawStriker()
    striker = display.newCircle(rootGroup, W/2, H, 8)
    striker:setFillColor(0, 0, 1)
    physics.addBody(striker, "dynamic", {radius=8, bounce=0.3, firction=0.3});
    striker.linearDamping = 0.5
    striker.name = "striker"
end

-- Draw board edges
drawBoardEdges()

-- Board Setup, data: Board data, level: [1..n]
local function drawBoard( data, level )
    -- Create root group
    rootGroup = display.newGroup()
    -- Draw lines
    drawLines(data, level)

    -- Draw Border
    drawBorder(data, level)

    --Draw marbles
    drawMarbles(data, level)

    -- Draw center
    drawCenter(data, level)

    -- Draw Striker
    drawStriker()
end

local function draw(  )
    message = display.newText("", xCenter, -88, native.systemFont, 20)
    message:setFillColor(1,0,0)
    
    levelMessage = display.newText(level, xCenter, -88, native.systemFont, 70)
    levelMessage:setFillColor(0,1,0,0.2)

    transition.to(levelMessage, {time=500, y=yCenter, transition=easing.outBounce})
    transition.to(levelMessage.fill, {time=500, a=1, transition=easing.inExpo,  onComplete=function()
        transition.to(levelMessage.fill, {time=1000, a=0, transition=easing.outBounce, onComplete=function()
            transition.to(levelMessage, {time=50, y=-(actualH-H)/2, onComplete=function()
                drawBoard(data, level) 
                isDrawInProgress = false
            end})
        end})

    end})
end

-- clear all display object
local function clearBoard()
    isDrawInProgress = true
    transition.to(rootGroup, {time=1000, alpha=0, transition=easing.inOutSine,
        onComplete= function()
            isStrikeInProgress = false
            display.remove(rootGroup)
            display.remove(message)
            display.remove(levelMessage)
            emptyTable(marbles)
            emptyTable(vertices)
            draw(data, level)
        end})
end

local function startGame()
    loadHistory()
    isDrawInProgress = true
    level = historyTable.currentLevel
    draw()    
end

startGame()

-----------------------------------------------------------------------------------------
--
-- Striker implementation
--
-----------------------------------------------------------------------------------------

local function strike( event )
    if(event.phase == "began") then
        print("strike began")

        for i = #aimCircles,1,-1 do
            display.remove(aimCircles[i])
            table.remove(aimCircles,i)
        end
    end

    if(event.phase == "moved") then
        
        if(striker == nil or striker._properties == nil) then return end
        local vx, vy = striker:getLinearVelocity()
        if(math.abs(vx) > 1 and math.abs(vy) > 1) then return end

        if(event.x == striker.x and event.y == striker.y) then return end
        local moveDistance = math.sqrt( (event.x-event.xStart)^2 + (event.y-event.yStart)^2 )
        if(moveDistance <= 10) then return end

        -- Remove circles
        for i = #aimCircles,1,-1 do
            display.remove(aimCircles[i])
            table.remove(aimCircles,i)
        end

        local slope = (event.y - striker.y)/(event.x - striker.x)
        local delta = (event.x - striker.x)/10
        local const = (striker.y*event.x - event.y*striker.x)/(event.x - striker.x)

        for i=0, 10 do
           local c = display.newCircle(striker.x + i*delta , 
                slope * (striker.x + i*delta) + const, 2 + i*0.07)
           c:setFillColor( 0, 0, 1 )
           table.insert( aimCircles, c)
        end
    end

    if(event.phase == "ended") then
        print("strike ended")
        if(striker == nil or striker._properties == nil) then return end
        local vx, vy = striker:getLinearVelocity()
        if(math.abs(vx) > 1 and math.abs(vy) > 1) then return end

        if(event.x == striker.x and event.y == striker.y or #aimCircles == 0) then return end
        
        if(navToggle) then
            toggleNav()
        end

        -- Remove circles
        for i = #aimCircles,1,-1 do
            display.remove(aimCircles[i])
            table.remove(aimCircles,i)
        end

        local xDiff = (event.x - striker.x)
        local yDiff = (event.y - striker.y)
        if(xDiff == 0 or yDiff == 0 ) then return end

        local yDirection = yDiff/math.abs( yDiff )
        local xDirection = xDiff/math.abs( xDiff )
        
        print("event.xStart", event.xStart,
            "event.yStart", event.yStart,
            "event.x", event.x,
            "event.y", event.y,
            "distance", math.sqrt( (event.x-event.xStart) * (event.x-event.xStart) + (event.y-event.yStart) * (event.y-event.yStart) )
        )
        local moveDistance = math.sqrt( (event.x-event.xStart)^2 + (event.y-event.yStart)^2 )
        if(moveDistance >= 10) then
            striker:setLinearVelocity( xDirection*math.abs( 1.5*xDiff ), 
                yDirection*math.abs( 1.5*yDiff ))
            isStrikeInProgress = true
        end
    end
end

background:addEventListener("touch", strike)

-----------------------------------------------------------------------------------------
--
-- handle click
--
-----------------------------------------------------------------------------------------

-- background tap event
local function onClick(  )
    print("Click Event")
    if(isDrawInProgress) then return end
    toggleNav()
end
background:addEventListener("tap", onClick)

-----------------------------------------------------------------------------------------
--
-- Check velocity
--
-----------------------------------------------------------------------------------------
local function isStrikerStopped()
    if(striker == nil) then 
        return true 
    end

    local vx, vy = striker:getLinearVelocity()
    if(math.abs(vx) <= 5 and math.abs(vy) <= 5) then
        return true
    else
        return false
    end
end

local function isCenterStopped()
    if(center == nil) then 
        return true 
    end

    local vx, vy = center:getLinearVelocity()
    if(math.abs(vx) <= 5 and math.abs(vy) <= 5) then
        return true
    else
        return false
    end
end

local function isMarbleStopped( marble )
    if(marble == nil or #marbles == 0) then 
        return true 
    end
    
    local vx, vy = marble:getLinearVelocity()
    if(math.abs(vx) <= 5 and math.abs(vy) <= 5) then
        return true
    else
        return false
    end
end

local function isMarblesStopped(  )
    for i = #marbles,1,-1 do
        if(not isMarbleStopped(marbles[i])) then return false end
    end
    return true
end

local function isObjectsStopped()
    if(#marbles == 0 and #vertices == 0) then return false end

    if( isStrikerStopped() 
        and isCenterStopped() 
        and isMarblesStopped()
    ) then
        return true
    else
        return false
    end
end

local function checkRules()
    local isStopped = isObjectsStopped()

    if(isStopped and isStrikeInProgress) then
        isStrikeInProgress = false

        if( strikerCollisionCount == 0) then
            print("Strike missed!! Reset Game")
            signalCollisionError("Missed")
            clearBoard()
            return
        elseif(strikerCollisionCount == 1) then
           print("Striker collision count: 1, otherCollisionBody", otherCollisionBody.name, otherCollisionBody.id)
           if(#marbles ~= 0 and otherCollisionBody.name == "center") then
                signalCollisionError("Clear green balls first")
                clearBoard()
                strikerCollisionCount = 0
                return
           end
           
           -- Check if striker or other body is inside of board
           local strikerHits = physics.rayCast(data[level].center.x, 
                data[level].center.y, striker.x, striker.y, "closest")
            -- print("strikerHits", json.prettify(strikerHits))

            -- local line1 = display.newLine(data[level].center.x, 
            --     data[level].center.y, striker.x, striker.y)
            -- line1.strokeWidth = 2
            -- line1:setStrokeColor(0,1,0)
           
           local otherBodyHits = physics.rayCast(data[level].center.x, 
                data[level].center.y, otherCollisionBody.x,otherCollisionBody.y, "closest")
            -- print("otherBodyHits", json.prettify(otherBodyHits))

            -- local line2 = display.newLine(data[level].center.x, 
            -- data[level].center.y, otherCollisionBody.x,otherCollisionBody.y)
            -- line2.strokeWidth = 2
            -- line2:setStrokeColor(1,0,0)

           if( strikerHits[1].object.name == "striker" ) then
                signalCollisionError("Striker inside board")
                clearBoard()
                strikerCollisionCount = 0
                return
           end

           if( otherBodyHits[1].object.name == "center" ) then
                signalCollisionError("Center inside board")
                clearBoard()
                strikerCollisionCount = 0
                return
            end

           if(otherBodyHits[1].object.name == "marble" and otherBodyHits[1].object.id == otherCollisionBody.id) then
                signalCollisionError("Other body inside board")
                clearBoard()
                strikerCollisionCount = 0
                return
           end 

           print("#marbles", #marbles)
           if(#marbles == 0) then
                level = level + 1;
                message:setFillColor(0,1,0) 
                displayMessage("You Won!!")
                clearBoard()
                strikerCollisionCount = 0
                return
           else
                -- Remove other body
                transition.to(otherCollisionBody, {time=500, alpha=0, onComplete=function()
                    display.remove(otherCollisionBody)
                    for i = #marbles, 1, -1 do
                        if(marbles[i].id == otherCollisionBody.id) then 
                            table.remove(marbles, i)
                            strikerCollisionCount = 0
                            return
                        end
                    end
                end})
           end
           

        elseif(strikerCollisionCount > 1) then
            signalCollisionError("Multiple collision")
            clearBoard()
        end

        print("Resetting striker collision count to 0")
        strikerCollisionCount = 0
    end
end

Runtime:addEventListener("enterFrame", checkRules)

-----------------------------------------------------------------------------------------
--
-- collision
--
-----------------------------------------------------------------------------------------

-- Signal Marbles collision error
local function marblesCollision(  )
    transition.to(border.fill, {
        time=2000,
        iterations=2,
        transition=easing.inOutSine,
        onComplete = function ( self )
            border:setFillColor(1,1,1,0)
        end,
        r=1, g=0, b=0, a=0.5
    })
end

-- Signal Marble and Center collision error
local function marbleAndCenterCollision(  )
    transition.to(border.fill, {
        time=1000,
        iterations=2,
        transition=easing.inOutSine,
        onComplete = function ( self )
            border:setFillColor(1,1,1,0)
        end,
        r=1, g=0, b=0, a=0.5
    })
end

-- Signal Striker and Marble collision error
local function strikerAndMarbleCollision(  )
    transition.to(border.fill, {
        time=1000,
        iterations=2,
        transition=easing.inOutSine,
        onComplete = function ( self )
            border:setFillColor(1,1,1,0)
        end,
        r=0, g=1, b=1, a=0.5
    })
end

-- Signal Striker and Center collision error
local function strikerAndCenterCollision(  )
    transition.to(border.fill, {
        time=1000,
        iterations=2,
        transition=easing.inOutSine,
        onComplete = function ( self )
            border:setFillColor(1,1,1,0)
        end,
        r=1, g=0, b=1, a=0.5
    })
end

-- Collision
local function onGlobalCollision( event )
    if(event.phase == "ended") then
        -- Skip collision sound for border and edges
        if(event.object1.name == "border" 
            or event.object2.name == "border"
            or event.object1.name == "edge"
            or event.object2.name == "edge"
        ) then
                return
            else 
                strikerCollisionCount = strikerCollisionCount + 1
                audio.play(collisionSound)
        end

        -- -- Signal error for collision between marbles
        -- if(event.object1.name == "marble" and event.object2.name == "marble" ) then
        --     strikerCollisionCount = strikerCollisionCount + 1
        --     print("marbles collided: strikerCollisionCount - ".. strikerCollisionCount)
        --     -- marblesCollision()
        --     if(strikerCollisionCount > 1) then 
        --         -- signalCollisionError("Green collision")
        --         -- clearBoard()
        --     end
        --     return
        -- end

        -- -- Signal error for marble and center collision
        -- if(event.object1.name == "marble" and event.object2.name == "center" 
        --     or event.object1.name == "center" and event.object2.name == "marble") then
        --         strikerCollisionCount = strikerCollisionCount + 1
        --         print("marble and center collided:strikerCollisionCount - " .. strikerCollisionCount)
        --         -- marbleAndCenterCollision()
        --         if(strikerCollisionCount > 1) then 
        --             -- signalCollisionError("Green red collision")
        --             -- clearBoard()
        --         end
        --         return
        -- end

        -- Signal error for striker and marble collision
        if(event.object1.name == "striker" and event.object2.name == "marble" 
            or event.object1.name == "marble" and event.object2.name == "striker") then
                if(event.object1.name == "striker") then 
                    otherCollisionBody = event.object2 
                else
                    otherCollisionBody = event.object1
                end
                return
        end

        -- Signal error for striker and marble collision
        if(event.object1.name == "striker" and event.object2.name == "center" 
            or event.object1.name == "center" and event.object2.name == "striker") then
                if(event.object1.name == "striker") then 
                    otherCollisionBody = event.object2 
                else
                    otherCollisionBody = event.object1
                end
                return
        end
    end
end

Runtime:addEventListener( "collision", onGlobalCollision )


local function unhandledErrorListener(  )
    print("unhandledErrorListener")
end

Runtime:addEventListener("unhandledError", unhandledErrorListener)


-----------------------------------------------------------------------------------------
--
-- Level navigation
--
-----------------------------------------------------------------------------------------
navLeft = display.newImage( "arrow_back.png" )
navLeft:translate( navLeft.width/2 + 5, actualH )

local function onNavLeftClick( event )
    if(isDrawInProgress) then return end
    if(level == 1) then 
        return
    else
        level = level - 1;
        historyTable.currentLevel = level
        saveHistory()
        clearBoard()
        toggleNav()
    end
end

navLeft:addEventListener("tap", onNavLeftClick)

navRight = display.newImage( "arrow_forward.png" )
navRight:translate( W-navRight.width/2 + 5, actualH )

local function onNavRightClick( event )
    if(isDrawInProgress) then return end
    if(level == #data) then
        return
    else
        level = level + 1;
        historyTable.currentLevel = level
        saveHistory()
        clearBoard()
        toggleNav()
    end
end

navRight:addEventListener("tap", onNavRightClick)

-----------------------------------------------------------------------------------------
--
-- Level Browser
--
-----------------------------------------------------------------------------------------
local function onBrowseButtonClicked(  )
     
end

browseLevel = display.newImage("browse.png")
browseLevel:translate(W/2, actualH)
-- browseLevel:addEventListener("tap", onBrowseButtonClicked)

browseRect = display.newRect(xCenter, actualH + yCenter, W, actualH)
browseRect:setFillColor(1,0,0)
