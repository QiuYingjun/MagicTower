local title = Class{}

local Button = require 'class.Button'

local menu = {}
local bw, bh = 200, FONT_MIDIUM:getHeight()
local bx, by = VIRTUAL_WIDTH / 2 - bw / 2, 250
local margin = 10

function title:init()
    table.insert(menu, Button(bx, by, bw, bh, "开始游戏", FONT_MIDIUM, function() Gamestate.switch(floor['story']) end))
    by = by + FONT_MIDIUM:getHeight() + margin
    table.insert(menu, Button(bx, by, bw, bh, "游戏说明", FONT_MIDIUM, function() Gamestate.switch(floor['help']) end))
    by = by + FONT_MIDIUM:getHeight() + margin
    table.insert(menu, Button(bx, by, bw, bh, "离开游戏", FONT_MIDIUM, function() love.event.quit() end))
end

function title:draw()
    push:start()
    love.graphics.clear(0.2, 0.2, 0.2, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("魔塔", FONT_BIG, 0, 50, VIRTUAL_WIDTH, "center")
    love.graphics.printf("Magic Tower", FONT_BIG, VIRTUAL_WIDTH * 0.5 * (1 - 0.5), 150, VIRTUAL_WIDTH, "center", 0, 0.5)
    love.graphics.printf("(Ver 0.00)", FONT_BIG, VIRTUAL_WIDTH * 0.5 * (1 - 0.2), 210, VIRTUAL_WIDTH, "center", 0, 0.2)

    for i, button in ipairs(menu) do
        button:draw()
    end
    displayFPS()
    push:finish()
end

function title:update(dt)
    for i, button in ipairs(menu) do
        button:update(dt)
    end
end

return title
