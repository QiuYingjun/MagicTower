local Entity = require "class.Entity"
local NPC = Class{__includes = Entity}
local cursorAlpha = 0
local signal = 1
function NPC:init(x, y, type, image, col, row)
    Entity.init(self, x, y, type, image)
    self.animation = anim8.newAnimation(g(col, row), 0.25)
    self.firstTalk = true
    self.talking = false
    self.shopping = false
    self.bag = {} -- 对话后赠送
    self.shop = {} --交易
    self.shopCursor = 1
    self.cursorAlpha = 0
    self.dialogs = {} -- 对话内容
    self.page = 1 -- 对话当前页数
    self.status = 1
end

function NPC:update(dt)
    Entity.update(self, dt)
    cursorAlpha = cursorAlpha + dt / 2 * signal
    if cursorAlpha > 1 then
        signal = -1
    elseif cursorAlpha < 0 then
        signal = 1
    end
end

function NPC:collide ()
    if #self.dialogs > 0 and self.status <= #self.dialogs and #self.dialogs[self.status] > 0 then
        self.talking = true
        hero.focus = self
        sound['page']:stop()
        sound['page']:play()
    elseif next(self.shop) ~= nil then
        hero.focus = self
        self.shopping = true
    else
        hero.focus = nil
    end
    print(self.type..' collide')
end

function NPC:showTalk()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(.1, .1, .1, .8)
    local x = (X0 + self.x) * WIDTH
    local y = self.y * HEIGHT
    local w = WIDTH * 4
    local h = HEIGHT * 2
    if X0 + self.x + 4 > MAP_SIZE then
        x = (X0 + self.x - 5) * WIDTH
    end
    if Y0 + self.y + 2 > MAP_SIZE then
        y = (Y0 + self.y - 2) * HEIGHT
    end
    love.graphics.rectangle('fill', x, y, w, h)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(self.dialogs[self.status][self.page], FONT_MICRO, x, y, w, 'left')
    love.graphics.setColor(r, g, b, a)
end

function NPC:showShop()
    local mx = (X0 + 2.5) * WIDTH
    local my = 3.5 * HEIGHT
    local mw = WIDTH * 6
    local mh = HEIGHT * 6
    local padding = 4
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(.1, .1, .1, .8)
    love.graphics.rectangle('fill', mx, my, mw, mh)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(self.shop['name'], FONT_SMALL, mx, my + HEIGHT / 2, mw, 'center')
    for i, option in ipairs(self.shop['menu']) do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(option['desc'], FONT_SMALL, mx, my + HEIGHT / 2 + i * HEIGHT, mw, 'center')
        if i == self.shopCursor then
            love.graphics.setColor(1, 1, 1, cursorAlpha)
            love.graphics.rectangle('line', mx + padding, my + HEIGHT / 2 + i * HEIGHT, mw - padding * 2, HEIGHT - padding * 2)
        end
    end
    love.graphics.setColor(r, g, b, a)
end

function NPC:keypressed(key)
    if self.shopping then
        if key == 'up' then
            if self.shopCursor == 1 then
                self.shopCursor = #self.shop['menu']
            else
                self.shopCursor = self.shopCursor - 1
            end
            sound['select']:stop()
            sound['select']:play()
        elseif key == 'down' then
            if self.shopCursor == #self.shop['menu'] then
                self.shopCursor = 1
            else
                self.shopCursor = self.shopCursor + 1
            end
            sound['select']:stop()
            sound['select']:play()
        elseif key == 'space' then
            self.shop['menu'][self.shopCursor].trade()
        end
    end
end

return NPC
