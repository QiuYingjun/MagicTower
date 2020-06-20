local FloorBase = require 'class.FloorBase'
local floor02 = FloorBase('第 2 层')
function floor02:init()
    self.floor = 2
    self.bgm = sound['bgm1']
    self.map = {
        {'F16', 'B12', 00000, 'E72', 00000, 'B12', 'I71', 'I72', 'I11', 'I13', 'B12'},
        {00000, 'B12', 'I72', 'B12', 'I22', 'B12', 'I71', 'I72', 'I11', 'I12', 'B12'},
        {00000, 'B12', 'I11', 'B12', 'I11', 'B12', 'I71', 'I72', 'I11', 'E71', 'B12'},
        {00000, 'B12', 'I11', 'B12', 'I11', 'B12', 'B12', 'B12', 'B12', 'D11', 'B12'},
        {00000, 'B12', 00000, 'B12', 00000, 00000, 00000, 'D11', 00000, 00000, 'B12'},
        {00000, 'B12', 'D11', 'B12', 'B12', 'D11', 'B12', 'B12', 'D11', 'B12', 'B12'},
        {00000, 'D14', 00000, 00000, 00000, 00000, 'B12', 00000, 'E71', 00000, 'B12'},
        {00000, 'B12', 'D11', 'B12', 'B12', 'D12', 'B12', 'D15', 'B12', 'D15', 'B12'},
        {00000, 'B12', 'I11', 'B12', 'I22', 'I21', 'B12', 00000, 'B12', 00000, 'B12'},
        {00000, 'B12', 'I11', 'B12', 'I22', 'I21', 'B12', 00000, 'B12', 00000, 'B12'},
        {'F18', 'B12', 'I71', 'B12', 'I22', 'I21', 'B12', 'C21', 'B12', 'C22', 'B12'},
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
function floor02:enter(prevStatus)
    if prevStatus and prevStatus.floor > self.floor then
        hero.x = 1
        hero.y = 10
        hero.direction = DIR_UP
    else
        hero.x = 1
        hero.y = 2
        hero.direction = DIR_DOWN
    end
    if prevStatus and prevStatus.bgm and prevStatus.bgm ~= self.bgm then
        prevStatus.bgm:stop()
        self.bgm:play()
    end
end

return floor02
