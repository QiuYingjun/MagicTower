local Entity = require "class.Entity"
local Door = Class{__includes = Entity}
local g = anim8.newGrid(WIDTH, HEIGHT, WIDTH * 4, HEIGHT * 4)
local colorMap = {'yellow', 'blue', 'red', 'white', 'fence'}
function Door:init(x, y, col)
    if col <= 4 then
        Entity.init(self, x, y, 'Door', image['D1'])
    else
        Entity.init(self, x, y, 'Fence', image['B1'])
    end
    self.color = colorMap[col]
    self.animation = anim8.newAnimation(g( math.min(col, 4), '1-4'), 0.25)
    self.animation:pauseAtStart()
    self.canOpen = false
    self.t = 0
end

function Door:update(dt)
    self.animation:update(dt)
    if self.canOpen then
        self.t = self.t + dt * 10
    end
    if self.t > 1 then
        self.die = true
        hero.refreshMap = true
        self.canOpen = false
    end
end
function Door:draw()
    self.animation:draw(self.image, (X0 + self.x - 1) * WIDTH, (Y0 + self.y - 1) * HEIGHT)
end

function Door:collide()
    if self.color == 'fence' then
        self.canOpen = true
        sound['fence']:play()
    elseif self.color == 'white' then
        sound['refuse']:play()
    elseif hero[self.color .. 'Key'] > 0 then
        hero[self.color .. 'Key'] = hero[self.color .. 'Key'] - 1
        sound['door']:play()
        self.canOpen = true
    else
        sound['refuse']:play()
    end
    if self.canOpen then
        self.animation:pauseAtEnd()
    end
end
return Door
