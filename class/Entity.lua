local Entity = Class{}

function Entity:init(x, y, type, image, quad)
    self.x = x
    self.y = y
    self.type = type
    assert(type)
    self.image = image
    self.quad = quad
    self.animation = nil
    self.die = false

    -- print(tostring(self))
end
function Entity:update(dt)
    if self.animation ~= nil then
        self.animation:update(dt)
    end
end
function Entity:draw()
    if self.animation ~= nil then
        self.animation:draw(self.image, (X0 + self.x - 1) * WIDTH, (Y0 + self.y - 1) * HEIGHT)
    else
        love.graphics.draw(self.image, self.quad,
        (X0 + self.x - 1) * WIDTH, (Y0 + self.y - 1) * HEIGHT)
    end
end
function Entity:collide()
end

function Entity:showTalk()
end


function Entity:__tostring()
    return self.type..':\t'..self.x..',\t'..self.y
end
return Entity
