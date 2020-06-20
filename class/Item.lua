local Entity = require 'class.Entity'
local Item = Class{__includes = Entity}
local nameMap = {
    ['I11'] = '黄钥匙 +1',
    ['I12'] = '蓝钥匙 +1',
    ['I13'] = '红钥匙 +1',
    ['I15'] = '各种钥匙 +1',
    ['I21'] = '生命值 +200',
    ['I22'] = '生命值 +500',
    ['I71'] = '攻击力 +3',
    ['I72'] = '防御力 +3',
    ['I41'] = '攻击力 +10',
}
function Item:init(x, y, type, image, quad)
    Entity.init(self, x, y, type, image, quad)
    self.bag = {}
end

function Item:collide ()
    for item, count in pairs(self.bag) do
        hero[item] = hero[item] + count
    end
    hero.x = self.x
    hero.y = self.y
    self.die = true
    hero.refreshMap = true
    sound['item']:stop()
    sound['item']:play()
    for k, v in pairs(self.bag) do
        print(k, v)
    end
    return nameMap[self.type]
end
return Item
