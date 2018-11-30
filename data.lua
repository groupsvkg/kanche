local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local MARBEL_RADIUS = 8
local CENTER_RADIUS = 8
local xPos = 70
local yPos = 70

local data = {
    -- LEVEL1 - vertical triangle
    {
        marbles = {
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL2 - inverted triangle
    {
        marbles = {
            {x = -xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL3 - inverted triangle with green balls on side mid
    {
        marbles = {
            {x = -xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 1/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -1/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL4 - inverted triangle with more green balls
    {
        marbles = {
            {x = -xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 3/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -3/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL5 - vertical triangle with more green balls on side mid
    {
        marbles = {
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 1/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -1/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },

    -- LEVEL6 - vertical triangle with more green balls
    {
        marbles = {
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 3/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -3/2*xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },

    -- LEVEL7 - Dimond 
    {
        marbles = {
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}}
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL8 - Square
    {
        marbles = {
            {x = -xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}}
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL9 - Square with green balls in side mid
    {
        marbles = {
            {x = -xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}}
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL10 - horizontal benzene
    {
        marbles = {
            {x = -xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos/2, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos/2, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos/2, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos/2, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL11 - Vertical benzene
    {
        marbles = {
            {x = 0, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos/2, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos/2, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos/2, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = -yPos/2, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL12 - Star
    {
        marbles = {
            {x = -xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = -yPos/2, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = -yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos/2, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = yPos/2, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos, y = yPos, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -xPos/2, y = 0, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL13 - Heptagon
    {
        marbles = {
            {x = -0, y = -100, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -78, y = -62, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -97, y = 22, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -43, y = 90, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 43, y = 90, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 97, y = 22, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 78, y = -62, r = MARBEL_RADIUS, color = {0, 1, 0}},
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL14 - Octagon
    {
        marbles = {
            {x = 38, y = -92, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -38, y = -92, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -92, y = -38, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -92, y = 38, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -38, y = 92, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 38, y = 92, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 92, y = 38, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 92, y = -38, r = MARBEL_RADIUS, color = {0, 1, 0}}
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    },
    -- LEVEL15 - Nonagon
    {
        marbles = {
            {x = -64, y = -77, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -98, y = -17, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -87, y = 50, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = -34, y = 94, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 34, y = 94, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 87, y = 50, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 98, y = -17, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 64, y = -77, r = MARBEL_RADIUS, color = {0, 1, 0}},
            {x = 0, y = -100, r = MARBEL_RADIUS, color = {0, 1, 0}}
        },
        center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
        edge = {
            borderStrokeWidth = 2,
            borderStrokeColor = {0, 0, 0, 0.5},
            borderFillColor = {1, 1, 1, 0},
            lineStrokeWidth = 2,
            lineStrokeColor = {0, 0, 0, 0.2}
        }
    }
    -- LEVEL16 - Union Shape
    -- {
    --     marbles = {
    --         {x = -95.249999, y = 302.29167, r = MARBEL_RADIUS, color = {0, 1, 0}},
    --         {x = 0, y = 249.375, r = MARBEL_RADIUS, color = {0, 1, 0}},
    --         {x = 100.54167, y = 302.29167, r = MARBEL_RADIUS, color = {0, 1, 0}},
    --         {x = 0, y = 360.5, r = MARBEL_RADIUS, color = {0, 1, 0}},
    --     },
    --     center = {x = xCenter, y = yCenter, r = CENTER_RADIUS, color = {1, 0, 0}},
    --     edge = {
    --         borderStrokeWidth = 2,
    --         borderStrokeColor = {0, 0, 0, 0.5},
    --         borderFillColor = {1, 1, 1, 0},
    --         lineStrokeWidth = 2,
    --         lineStrokeColor = {0, 0, 0, 0.2}
    --     }
    -- }
}

return data
