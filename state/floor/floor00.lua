local FloorBase = require 'class.FloorBase'
local floor00 = FloorBase('序章')

function floor00:init()
    self.floor = 0
    self.bgm = sound['bgm0']
    self.bgm:setLooping(true)

    self.map = {
        {'B12', 'B23', 'B23', 'B23', 'B23', 'F18', 'B23', 'B23', 'B23', 'B23', 'B12'},
        {'B12', 'B23', 'B23', 'B23', 'B23', 00000, 'B23', 'B23', 'B23', 'B23', 'B12'},
        {'B12', 'B23', 'B23', 'B23', 'B23', 00000, 'B23', 'B23', 'B23', 'B23', 'B12'},
        {'B12', 'B23', 'B23', 'B23', 'B23', 00000, 'B23', 'B23', 'B23', 'B23', 'B12'},
        {'B12', 'B23', 'B23', 'B23', 'B23', 00000, 'B23', 'B23', 'B23', 'B23', 'B12'},
        {'B12', 'B23', 'B23', 'B23', 'B23', 00000, 'B23', 'B23', 'B23', 'B23', 'B12'},
        {'B12', 'B12', 'B23', 'B23', 'B23', 00000, 'B23', 'B23', 'B23', 'B12', 'B12'},
        {'B12', 'B12', 'B12', 'B12', 'B12', 'D11', 'B12', 'B12', 'B12', 'B12', 'B12'},
        {'B21', 'B12', 'B21', 'B12', 00000, 'C24', 00000, 'B12', 'B21', 'B12', 'B21'},
        {'B21', 'B21', 'B21', 'B21', 'B21', 00000, 'B21', 'B21', 'B21', 'B21', 'B21'},
        {'B21', 'B21', 'B21', 'B21', 'B21', 00000, 'B21', 'B21', 'B21', 'B21', 'B21'}
    }
    self.entities = {}
    for y, row in ipairs(self.map) do
        for x, tile in ipairs(row) do
            local entity = generator(x, y, tile, self.floor)
            if entity then
                table.insert(self.entities, entity)
                self.map[y][x] = entity
            end
        end
    end
end
function floor00:enter(prevStatus)
    if prevStatus.floor > self.floor then
        hero.x = 6
        hero.y = 2
        hero.direction = DIR_UP
    else
        hero.x = 6
        hero.y = 10
        hero.direction = DIR_DOWN
    end
    if prevStatus.bgm and prevStatus.bgm ~= self.bgm then
        prevStatus.bgm:stop()
    end
    self.bgm:play()
end

return floor00
