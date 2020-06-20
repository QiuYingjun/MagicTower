local FloorBase = require 'class.FloorBase'
local floor05 = FloorBase('第 5 层')
function floor05:init()
    self.floor = 5
    self.bgm = sound['bgm1']
    self.map = {
        {'I15', 'B12', 'I21', 'B12', 00000, 'E61', 00000, 00000, 'E61', 'I11', 00000},
        {00000, 'B12', 'I71', 'B12', 'E61', 00000, 00000, 00000, 00000, 'E61', 'I11'},
        {'E32', 'B12', 00000, 'B12', 'E22', 00000, 'B12', 'B12', 'D11', 'B12', 'B12'},
        {00000, 'D11', 'E61', 'B12', 00000, 'E22', 'B12', 00000, 'E91', 'E22', 'C22'},
        {'E32', 'B12', 00000, 'B12', 'B12', 'B12', 'B12', 00000, 00000, 00000, 'E22'},
        {'I71', 'B12', 00000, 00000, 00000, 'E31', 'E21', 00000, 00000, 00000, 00000},
        {'I72', 'B12', 'B12', 'E13', 'B12', 'B12', 'B12', 'B12', 00000, 00000, 00000},
        {00000, 'C21', 'B12', 'E13', 'B12', 00000, 00000, 00000, 'E91', 'E51', 00000},
        {'B12', 'B12', 'B12', 'E31', 'B12', 'D11', 'B12', 'D12', 'B12', 'D11', 'B12'},
        {00000, 00000, 'B12', 00000, 'B12', 'E31', 'B12', 'I72', 'D11', 00000, 'B12'},
        {'F16', 00000, 'E31', 00000, 00000, 00000, 'B12', 'I11', 'B12', 'F18', 'B12'}
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
function floor05:enter(prevStatus)
    -- if prevStatus.floor > self.floor then
    --     hero.x = 10
    --     hero.y = 10
    --     hero.direction = DIR_UP
    -- else
    hero.x = 2
    hero.y = 11
    --     hero.direction = DIR_DOWN
    -- end
    -- if prevStatus.bgm and prevStatus.bgm ~= self.bgm then
    --     prevStatus.bgm:stop()
    --     self.bgm:play()
    -- end
end

return floor05
