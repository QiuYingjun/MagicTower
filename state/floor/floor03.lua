local FloorBase = require 'class.FloorBase'
local floor03 = FloorBase('第 3 层')
function floor03:init()
    self.floor = 3
    self.bgm = sound['bgm1']
    self.map = {
        {'I41', 'E12', 'I11', 'B12', 'C31', 'C32', 'C33', 'B12', 'B12', 'B12', 'B12'},
        {'E12', 'I11', 00000, 'B12', 00000, 00000, 00000, 'B12', 00000, 'E31', 00000},
        {'I11', 'E21', 00000, 'B12', 'B12', 'D11', 'B12', 'B12', 00000, 'B12', 00000},
        {'B12', 'D11', 'B12', 'B12', 00000, 'E21', 00000, 'B12', 'I11', 'B12', 'E12'},
        {00000, 00000, 00000, 'B12', 'B12', 'B12', 00000, 'B12', 'I11', 'B12', 'E31'},
        {'E11', 'B12', 00000, 'E31', 'E12', 'E31', 00000, 'B12', 'I11', 'B12', 'E12'},
        {'E11', 'B12', 'B12', 'B12', 'B12', 'B12', 00000, 00000, 00000, 'B12', 00000},
        {00000, 00000, 00000, 00000, 00000, 'B12', 'B12', 'D11', 'B12', 'B12', 00000},
        {'B12', 'B12', 'B12', 'B12', 'E31', 'B12', 'E12', 00000, 'E12', 'B12', 00000},
        {'B12', 00000, 00000, 00000, 00000, 'B12', 'I72', 'E31', 'I11', 'B12', 00000},
        {'F16', 00000, 'B12', 'B12', 'B12', 'B12', 'I71', 'I22', 'I11', 'B12', 'F18'}
    }
    self.entities = {}
    for y, row in ipairs(self.map) do
        for x, tile in ipairs(row) do
            entity = generator(x, y, tile, self.floor)
            if entity then
                table.insert(self.entities, entity)
                self.map[y][x] = entity
            end
        end
    end
end
function floor03:enter(prevStatus)
    if prevStatus.floor > self.floor then
        hero.x = 11
        hero.y = 10
        hero.direction = DIR_UP
    else
        hero.x = 2
        hero.y = 11
        hero.direction = DIR_DOWN
    end
    if prevStatus.bgm and prevStatus.bgm ~= self.bgm then
        prevStatus.bgm:stop()
        self.bgm:play()
    end
end

return floor03
