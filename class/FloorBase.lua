local FloorBase = Class{}
local enemyInfo = require "state.enemyInfo"
local framework = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}


function FloorBase:init(name)
    self.framework = framework
    self.name = name
    self.entities = {}
    self.map = {
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000, 00000}
    }
    self.curtainAlpha = 0
end

function FloorBase:update(dt)
    if hero.refreshMap then
        for y, row in ipairs(self.map) do
            for x, entity in ipairs(row) do
                if type(entity) ~= "string" and type(entity) ~= "number" then
                    if entity.die then
                        self.map[entity.y][entity.x] = 00000
                    elseif entity.x ~= x or entity.y ~= y then
                        self.map[entity.y][entity.x] = entity
                        self.map[y][x] = 0
                    end
                end
            end
        end
        hero.refreshMap = false
        for j = #self.entities, 1, - 1 do
            if self.entities[j].die then
                table.remove(self.entities, j)
            end
        end
    end

    for i, entity in ipairs(self.entities) do
        entity:update(dt)
    end
    hero:update(dt)
    if self.curtainAlpha > 0 then
        self.curtainAlpha = self.curtainAlpha - dt
    else
        self.curtainAlpha = 0
    end
    --self:printHeroAround(dt)
end

function FloorBase:draw()
    push:start()
    self:drawBase()

    for i, entity in ipairs(self.entities) do
        if not entity.die then
            entity:draw()
        end
    end

    for i, entity in ipairs(self.entities) do
        if not entity.die then
            if entity.talking then
                entity:showTalk()
            elseif entity.shopping then
                entity:showShop()
            end
        end
    end
    hero:draw()
    if self.curtainAlpha > 0 then
        self:showCurtain()
    end
    push:finish()
end

function FloorBase:drawBase()
    for i, row in ipairs(self.framework) do
        for j, tile in ipairs(row) do
            if tile == 0 then
                love.graphics.draw(image['F1'], quads[1],
                (j - 1) * WIDTH, (i - 1) * HEIGHT)
            elseif tile == 1 then
                love.graphics.draw(image['B1'], quads[1],
                (j - 1) * WIDTH, (i - 1) * HEIGHT)
            end
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(image['C1'], quads[1], WIDTH * 1.2, HEIGHT * 1.2)
    love.graphics.printf(tostring(hero.level), FONT_MIDIUM, 3 * WIDTH, HEIGHT * 1.3, WIDTH, 'left')
    love.graphics.printf('级', FONT_SMALL, 4 * WIDTH, HEIGHT * 1.5, WIDTH, 'left')

    local panel = {
        {'生命', hero.life},
        {'攻击', hero.attack},
        {'防御', hero.defense},
        {'金币', hero.money},
        {'经验', hero.exp}
    }
    local x = WIDTH + WIDTH / 4
    local y = 2.5 * HEIGHT
    local margin = HEIGHT / 4

    for i, pair in ipairs(panel) do
        key, value = unpack(pair)
        love.graphics.printf(key, FONT_SMALL, x, y, WIDTH * 2, 'left' )
        love.graphics.printf(tostring(value), FONT_SMALL, x + WIDTH + WIDTH / 4, y, 2 * WIDTH, 'right' )
        y = y + HEIGHT - margin
    end
    y = y - HEIGHT * 0.75
    local key_bag = {hero.yellowKey, hero.blueKey, hero.redKey}
    for i = 1, 3 do
        love.graphics.draw(image['I1'], quads[i], x, y + i * HEIGHT)
        love.graphics.printf(tostring(key_bag[i]), FONT_MIDIUM, WIDTH * 3, y + i * HEIGHT, WIDTH, 'center')
        love.graphics.printf('个', FONT_SMALL, WIDTH * 4, y + i * HEIGHT + margin, WIDTH, 'left')
    end

    y = y + HEIGHT * 4.25
    love.graphics.printf(self.name, FONT_SMALL, WIDTH, y, WIDTH * 4, 'center')
    y = y + HEIGHT * 1
    love.graphics.printf('S 保存  Q 退出程序', FONT_MICRO, WIDTH, y, WIDTH * 4, 'center')
    y = y + HEIGHT / 2
    love.graphics.printf('A 读取  R 重新开始', FONT_MICRO, WIDTH, y, WIDTH * 4, 'center')

    displayFPS()
end

function FloorBase:keypressed(key)
    if hero.focus then
        if key == 'escape' then
            hero.focus.shopping = false
            hero.focus.talking = false
            hero.focus = nil
        else
            hero.focus:keypressed(key)
        end
    else
        if key == 'up' then
            hero.direction = DIR_UP
            hero:move(self:getHeroFront())
        elseif key == 'right' then
            hero.direction = DIR_RIGHT
            hero:move(self:getHeroFront())
        elseif key == 'down' then
            hero.direction = DIR_DOWN
            hero:move(self:getHeroFront())
        elseif key == 'left' then
            hero.direction = DIR_LEFT
            hero:move(self:getHeroFront())
        elseif key:upper() == 'L' and hero.damageCross > 0 then
            Gamestate.push(enemyInfo)
        end
    end
end

local t = 0
local round = 0
function FloorBase:printHeroAround(dt)
    t = t + dt
    if t > 1 then
        t = 0
        round = round + 1
        print('----------------------------------------')
        print('time:\t' .. round .. 's')
        print('floor:\t' .. self.name)
        local a, b, c, d = 'nil', 'nil', 'nil', 'nil'
        if hero.y - 1 >= 1 then
            a = tostring(self.map[hero.y - 1][hero.x])
        end
        if hero.x + 1 <= MAP_SIZE then
            b = tostring(self.map[hero.y][hero.x + 1])
        end
        if hero.y + 1 <= MAP_SIZE then
            c = tostring(self.map[hero.y + 1][hero.x])
        end
        if hero.x - 1 >= 1 then
            d = tostring(self.map[hero.y][hero.x - 1])
        end
        print('\t'.. a .. '\t')
        print(d .. '\t\t' .. b )
        print('\t' .. c .. '\t')
        print('front:\t' .. tostring(self:getHeroFront()))
    end
end

function FloorBase:getHeroFront()
    if hero.direction == DIR_UP then
        if hero.y == 1 then return nil else return self.map[hero.y - 1][hero.x] end
    elseif hero.direction == DIR_RIGHT then
        if hero.x == MAP_SIZE then return nil else return self.map[hero.y][hero.x + 1] end
    elseif hero.direction == DIR_DOWN then
        if hero.y == MAP_SIZE then return nil else return self.map[hero.y + 1][hero.x] end
    elseif hero.direction == DIR_LEFT then
        if hero.x == 1 then return nil else return self.map[hero.y][hero.x - 1] end
    end
end

function FloorBase:showCurtain()
    love.graphics.setColor(0, 0, 0, self.curtainAlpha)
    love.graphics.rectangle('fill', X0 * WIDTH, Y0 * WIDTH, WIDTH * 11, HEIGHT * 11)
    love.graphics.setColor(1, 1, 1, self.curtainAlpha)
    love.graphics.printf("魔塔", FONT_BIG, X0 * WIDTH, (Y0 + 2) * WIDTH, WIDTH * 11, "center")
    love.graphics.printf("Magic Tower", FONT_MIDIUM, X0 * WIDTH, (Y0 + 5) * WIDTH, WIDTH * 11, "center")
    love.graphics.printf(self.name, FONT_MIDIUM, X0 * WIDTH, (Y0 + 7) * WIDTH, WIDTH * 11, "center")
end

return FloorBase
