local enemyInfo = {}

function enemyInfo:enter(currentFloor)
    self.enemies = {}
    self.enemySet = {}
    self.currentFloor = currentFloor
    for i, entity in ipairs(currentFloor.entities) do
        if entity.type:sub(1, 1) == 'E' and self.enemySet[entity.name] == nil then
            table.insert(self.enemies, entity)
            self.enemySet[entity.name] = 1
        end
    end
    table.sort(self.enemies,
        function(a, b)
            if a:getDamage() ~= b:getDamage() then
                return a:getDamage() < b:getDamage()
            else
                return a.attack < b.attack
            end
        end
    )
end

function enemyInfo:update(dt)
    self.currentFloor:update(dt)
end

function enemyInfo:draw()
    push:start()

    self.currentFloor:drawBase()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle('fill', X0 * WIDTH, Y0 * HEIGHT, WIDTH * 11, HEIGHT * 11)
    local leftPadding = 15
    local topPadding = 10
    for i, enemy in ipairs(self.enemies) do
        love.graphics.setColor(1, 1, 1, 1)
        local x = X0 * WIDTH + leftPadding
        local y = (Y0 + i - 1) * (HEIGHT + topPadding)
        love.graphics.draw(image['F1'], quads[1], x, y)
        enemy.animation:draw(enemy.image, x, y)
        love.graphics.printf('名称 '..enemy.name, FONT_MICRO, x + WIDTH * 1.5, y, WIDTH * 2.5, 'left' )
        love.graphics.printf('生命 '..enemy.hp, FONT_MICRO, x + WIDTH * 1.5, y + HEIGHT / 2, WIDTH * 2.5, 'left' )
        love.graphics.printf('攻击 '..enemy.attack, FONT_MICRO, x + WIDTH * 4, y, WIDTH * 2, 'left' )
        love.graphics.printf('防御 '..enemy.defense, FONT_MICRO, x + WIDTH * 4, y + HEIGHT / 2, WIDTH * 2, 'left' )
        love.graphics.printf('金币 '..enemy.money, FONT_MICRO, x + WIDTH * 6, y, WIDTH * 2, 'left' )
        love.graphics.printf('经验 '..enemy.exp, FONT_MICRO, x + WIDTH * 6, y + HEIGHT / 2, WIDTH * 2, 'left' )
        if enemy.defense >= hero.attack then
            love.graphics.printf('打穿 攻+'..(enemy.defense - hero.attack + 1), FONT_MICRO, x + WIDTH * 8, y, WIDTH * 2, 'left' )
            love.graphics.setColor(1, 0, 0, 1)
            love.graphics.printf('损失 ????', FONT_MICRO, x + WIDTH * 8, y + HEIGHT / 2, WIDTH * 2, 'left' )
        elseif enemy:getDamage() > 0 then
            love.graphics.printf('无伤 防+'..(enemy.attack - hero.defense), FONT_MICRO, x + WIDTH * 8, y, WIDTH * 2, 'left' )
            love.graphics.printf('损失 '..tostring(enemy:getDamage()), FONT_MICRO, x + WIDTH * 8, y + HEIGHT / 2, WIDTH * 2, 'left' )
        else
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.printf('无伤', FONT_MICRO, x + WIDTH * 8, y + HEIGHT / 4, WIDTH * 2, 'left' )
        end
    end
    love.graphics.setColor(r, g, b, a)
    push:finish()

end

function enemyInfo:keypressed(key)
    if key:upper() == 'L' then
        Gamestate.pop()
    end
end
return enemyInfo
