local story = Class{}

local alpha = 0
local direction = 1
local text = '很久很久以前\n'..
'巨龙突然出现\n'..
'带来灾难带走了公主又消失不见\n'..
'王国十分危险\n'..
'世间谁最勇敢\n'..
'一位勇者赶来大声喊\n'..
'我要带上最好的剑\n'..
'翻过最高的山\n'..
'闯进最深的森林\n'..
'把公主带回到面前\n'..
'国王非常高兴\n'..
'忙问他的姓名\n'..
'年轻人想了想\n'..
'他说...'
function story:init()
    self.floor = -1
end
local text_y = VIRTUAL_HEIGHT
function story:enter()
    text_y = VIRTUAL_HEIGHT
end
function story:draw()
    push:start()
    love.graphics.setFont(FONT_SMALL)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('故事', 0, 0, VIRTUAL_WIDTH, 'center')
    push:finish()
end

function story:draw()
    push:start()
    -- 剧情文本
    love.graphics.setFont(FONT_SMALL)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(text, FONT_SMALL, 40, text_y, VIRTUAL_WIDTH - 40, 'left')
    -- 标题
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, FONT_SMALL:getHeight())
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('故事', FONT_SMALL, 0, 0, VIRTUAL_WIDTH, 'center')
    -- 页脚
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT - FONT_SMALL:getHeight(), VIRTUAL_WIDTH, FONT_SMALL:getHeight())
    love.graphics.setColor(1, 1, 1, alpha)
    love.graphics.printf('空格键跳过', FONT_MICRO, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH / 2, 'center')
    displayFPS()
    push:finish()
end

function story:update(dt)
    alpha = alpha + dt * direction
    if alpha > 1 then
        direction = -1
    elseif alpha < 0 then
        direction = 1
    end
    text_y = text_y - dt * 50

    if text_y + FONT_SMALL:getHeight() * 14 < - 10 then
        Gamestate.switch(floor[0])
    end
end

function story:keypressed(key)
    if key == 'space' then
        Gamestate.switch(floor[0])
    end
end

return story
