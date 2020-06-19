local FloorBase = require 'class.FloorBase'
local floor01 = FloorBase('第 1 层')
function floor01:init()
    self.floor = 1
    self.bgm = sound['bgm1']
    self.bgm:setLooping(true)
    self.map = {
        {'F18', 00000, 'I11', 'E11', 'E12', 'E11', 00000, 00000, 00000, 00000, 00000},
        {'B12', 'B12', 'B12', 'B12', 'B12', 'B12', 'B12', 'B12', 'B12', 'B12', 00000},
        {'I21', 00000, 'E21', 'D11', 00000, 'B12', 'I21', 'I11', 'I21', 'B12', 00000},
        {'I11', 'E21', 'I71', 'B12', 00000, 'B12', 'I21', 'I11', 'I21', 'B12', 00000},
        {'B12', 'D11', 'B12', 'B12', 00000, 'B12', 'B12', 'B12', 'E13', 'B12', 00000},
        {'I11', 'E22', 00000, 'B12', 00000, 'D11', 'E61', 'E11', 'E31', 'B12', 00000},
        {'I72', 00000, 'I12', 'B12', 00000, 'B12', 'B12', 'B12', 'B12', 'B12', 00000},
        {'B12', 'D11', 'B12', 'B12', 00000, 00000, 00000, 00000, 00000, 00000, 00000},
        {00000, 'E22', 00000, 'B12', 'B12', 'D13', 'B12', 'B12', 'B12', 'D11', 'B12'},
        {'I21', 'I22', 'I11', 'B12', 'I13', 00000, 00000, 'B12', 'I11', 'E91', 'I12'},
        {'I21', 'I39', 'I11', 'B12', 00000, 'F16', 00000, 'B12', 'I11', 'I11', 'I11'}
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
function floor01:enter(prevStatus)
    if prevStatus.floor > self.floor then
        hero.x = 2
        hero.y = 1
        hero.direction = DIR_UP
    else
        hero.x = 6
        hero.y = 10
        hero.direction = DIR_DOWN
    end
    if prevStatus.bgm and prevStatus.bgm ~= self.bgm then
        prevStatus.bgm:stop()
        self.bgm:play()
    end
end

return floor01
