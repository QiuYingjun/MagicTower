local FloorBase = require 'class.FloorBase'
local floor04 = FloorBase('第 4 层')
function floor04:init()
    self.floor = 4
    self.bgm = sound['bgm1']
    self.map = {
        {00000, 'E13', 00000, 'B12', 00000, 'C23', 00000, 'B12', 00000, 'E13', 00000},
        {'D11', 'B12', 'D11', 'B12', 00000, 00000, 00000, 'B12', 'D11', 'B12', 'D11'},
        {00000, 'B12', 00000, 'B12', 'B12', 'D15', 'B12', 'B12', 00000, 'B12', 00000},
        {00000, 'B12', 'E21', 'B12', 'E32', 'E33', 'E32', 'B12', 'E21', 'B12', 00000},
        {'E31', 'B12', 'I21', 'B12', 'I72', 'E32', 'I72', 'B12', 'I21', 'B12', 'E31'},
        {'E31', 'B12', 'I21', 'B12', 'B12', 'D13', 'B12', 'B12', 'I21', 'B12', 'E31'},
        {'E12', 'B12', 00000, 'B12', 'E91', 'E51', 'E91', 'B12', 00000, 'B12', 'E12'},
        {00000, 'B12', 00000, 'B12', 'I71', 'E91', 'I71', 'B12', 00000, 'B12', 00000},
        {00000, 'B12', 00000, 'B12', 'B12', 'D12', 'B12', 'B12', 00000, 'B12', 00000},
        {00000, 'B12', 00000, 'B12', 'I11', 00000, 'I11', 'B12', 00000, 'B12', 00000},
        {'F18', 'B12', 00000, 'E13', 00000, 00000, 00000, 'E13', 00000, 'B12', 'F16'}
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
function floor04:enter(prevStatus)
    -- if prevStatus.floor > self.floor then
    --     hero.x = 1
    --     hero.y = 10
    --     hero.direction = DIR_UP
    -- else
    hero.x = 11
    hero.y = 10
    hero.direction = DIR_DOWN
    -- end
    -- if prevStatus.bgm and prevStatus.bgm ~= self.bgm then
    --     prevStatus.bgm:stop()
    --     self.bgm:play()
    -- end
end

return floor04
