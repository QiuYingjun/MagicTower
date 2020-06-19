local NPC = require "class.NPC.NPC"
local Robot = Class{__includes = NPC}
function Robot:init(x, y, floorNum)
    NPC.init(self, x, y, 'Robot', image['C3'], 2, 1)
    self.shop = {
        ['name'] = '3层商店',
        ['menu'] = {
            {
                ['desc'] = '增加800点生命值',
                ['trade'] = function()
                    if hero.money > 25 then
                        hero.money = hero.money - 25
                        hero.life = hero.life + 800
                        sound['item']:stop()
                        sound['item']:play()
                    else
                        sound['refuse']:stop()
                        sound['refuse']:play()
                    end
                end
            },
            {
                ['desc'] = '增加4点攻击力',
                ['trade'] = function()
                    if hero.money > 25 then
                        hero.money = hero.money - 25
                        hero.attack = hero.attack + 4
                        sound['item']:stop()
                        sound['item']:play()
                    else
                        sound['refuse']:stop()
                        sound['refuse']:play()
                    end
                end
            },
            {
                ['desc'] = '增加4点防御力',
                ['trade'] = function()
                    if hero.money > 25 then
                        hero.money = hero.money - 25
                        hero.defense = hero.defense + 4
                        sound['item']:stop()
                        sound['item']:play()
                    else
                        sound['refuse']:stop()
                        sound['refuse']:play()
                    end
                end
            },
            {
                ['desc'] = '离开',
                ['trade'] = function()
                    hero.focus.shopping = false
                    hero.focus = nil
                end
            },
        }
    }
end
return Robot
