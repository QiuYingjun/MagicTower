local Button = Class{}

local DEFAULT_COLOR = {0.2, 0.2, 0.2, 0}
local LABEL_DEFAULT_COLOR = {1, 1, 1, 1}
local HOT_COLOR = {0.8, 0.8, 0.8, 1}
local LABEL_HOT_COLOR = {0, 0, 0, 1}

function Button:init(x, y, width, height, label, font, fn)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.label = label
    self.fn = fn
    self.last_pressed = false
    self.now_pressed = false
    self.last_mouse_on = false
    self.now_mouse_on = false
    self.color = DEFAULT_COLOR
    self.label_color = LABEL_DEFAULT_COLOR
    self.font = font
end

function Button:update(dt)
    local x, y = push:toGame(love.mouse.getPosition())
    if x == nil then x = -1 end
    if y == nil then y = -1 end
    self.now_pressed = love.mouse.isDown(1)
    if x > self.x and x < self.x + self.width
    and y > self.y and y < self.y + self.height then
        self.color = HOT_COLOR
        self.label_color = LABEL_HOT_COLOR
        self.now_mouse_on = true
    else
        self.color = DEFAULT_COLOR
        self.label_color = LABEL_DEFAULT_COLOR
        self.now_mouse_on = false
    end

    if not self.last_mouse_on and self.now_mouse_on then
        sound['select']:stop()
        sound['select']:play()
    end
    if self.now_mouse_on and not self.last_pressed and self.now_pressed then
        sound['start']:play()
        self.fn()
    end
    self.last_pressed = self.now_pressed
    self.last_mouse_on = self.now_mouse_on
end

function Button:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(unpack(self.label_color))
    love.graphics.printf(self.label,
        self.font,
        self.x,
        self.y + self.height / 2 - self.font:getHeight(self.label) / 2,
        self.width,
        "center"
    )
end

return Button
