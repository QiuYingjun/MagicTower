local hero_image = image['C1']
local g = anim8.newGrid(WIDTH, HEIGHT + 1, hero_image:getWidth(), hero_image:getHeight())
local Entity = require 'class.Entity'
local animation = {} -- anim8.newAnimation(g('1-4',4),0.25)
animation[DIR_UP] = anim8.newAnimation(g('1-4', 4), 0.25)
animation[DIR_RIGHT] = anim8.newAnimation(g('1-4', 3), 0.25)
animation[DIR_DOWN] = anim8.newAnimation(g('1-4', 1), 0.25)
animation[DIR_LEFT] = anim8.newAnimation(g('1-4', 2), 0.25)
Hero = Class{__includes = Entity}
function Hero:init(x, y)
    Entity.init(self, x, y, 'hero', hero_image)

    self.direction = DIR_UP
    self.animation = animation[DIR_UP]

    self.level = 1
    self.hp = 1000
    self.attack = 10
    self.defense = 10
    self.money = 0
    self.exp = 0
    self.yellowKey = 0
    self.blueKey = 0
    self.redKey = 0

    self.damageCross = 1
    self.rockPick = 0
    self.fairyCross = 0

    self.focus = nil
    self.refreshMap = false

    self.sloganText = nil
    self.sloganAlpha = 0
end

function Hero:update(dt)
    Entity.update(self, dt)

    if self.sloganAlpha > 0 then
        self.sloganAlpha = self.sloganAlpha - dt
    elseif self.sloganAlpha < 0 then
        self.sloganText = nil
        self.sloganAlpha = 0
    end
end

function Hero:draw()
    Entity.draw(self)
    if self.sloganText then
        self:showSlogan()
    end
end

function Hero:move(front)
    self.animation = animation[self.direction]
    if front == 0 then
        if self.direction == DIR_UP then
            self.y = self.y - 1
        elseif self.direction == DIR_RIGHT then
            self.x = self.x + 1
        elseif self.direction == DIR_DOWN then
            self.y = self.y + 1
        elseif self.direction == DIR_LEFT then
            self.x = self.x - 1
        end
        sound['move']:stop()
        sound['move']:play()
    elseif front ~= nil and type(front) ~= "number" and type(front) ~= "string" then
        local res = front:collide()
        if res then
            self.sloganText = res
            self.sloganAlpha = 1
        end
    end
end

function Hero:showSlogan()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 0, 0, self.sloganAlpha)
    love.graphics.rectangle('fill', X0 * WIDTH, (Y0 + 4) * HEIGHT, VIRTUAL_WIDTH, HEIGHT * 2)
    love.graphics.setColor(1, 1, 1, self.sloganAlpha)
    love.graphics.printf(self.sloganText, FONT_MIDIUM, X0 * WIDTH, (Y0 + 4.5) * HEIGHT, WIDTH * 11, 'center')
    love.graphics.setColor(r, g, b, a)
end
