local help = Class{}

local Button = require 'class.Button'

local backButton = Button(VIRTUAL_WIDTH / 2 - 100,
    VIRTUAL_HEIGHT - 100,
    200,
    FONT_SIZE_SMALL,
    '返回',
    FONT_SMALL,
    function () Gamestate.switch(floor['title']) end
)
function help:update(dt)
    backButton:update(dt)
end

function help:draw()
    push:start()
    love.graphics.setFont(FONT_SMALL)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('游戏说明', 0, 0, VIRTUAL_WIDTH, 'center')
    backButton:draw()
    push:finish()
end

return help
