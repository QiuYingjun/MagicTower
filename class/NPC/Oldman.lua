local NPC = require "class.NPC.NPC"
local Oldman = Class{__includes = NPC}
function Oldman:init(x, y, floorNum)
    NPC.init(self, x, y, 'Oldman', image['C2'], '1-4', 1)
    self.floorNum = floorNum
    if self.floorNum == 2 then
        self.dialogs = {
            {'老人：给你一把剑', '勇士：谢谢'}
        }
    elseif self.floorNum == 5 then
        self.dialogs = {
            {'老人：你好，英雄的人类，只要你有足够的经验，我就可以让你变得更强大'}
        }
        self.shop = {
            ['name'] = '5层经验商店',
            ['menu'] = {
                {
                    ['desc'] = '提升一级',
                    ['trade'] = function()
                        if hero.exp >= 100 then
                            hero.exp = hero.exp - 100
                            hero.hp = hero.hp + 1000
                            hero.attack = hero.attack + 7
                            hero.defense = hero.defense + 7
                            hero.level = hero.level + 1
                            return true
                        end
                        return false
                    end
                },
                {
                    ['desc'] = '增加5点攻击力',
                    ['trade'] = function()
                        if hero.exp >= 30 then
                            hero.exp = hero.exp - 30
                            hero.attack = hero.attack + 5
                            return true
                        end
                        return false
                    end
                },
                {
                    ['desc'] = '增加5点防御力',
                    ['trade'] = function()
                        if hero.exp >= 30 then
                            hero.exp = hero.exp - 30
                            hero.def = hero.def + 5
                            return true
                        end
                        return false
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
    elseif self.floorNum == 13 then
        self.dialogs = {
            {'老人：你好，英雄的人类，只要你有足够的经验，我就可以让你变得更强大'}
        }
        self.shop = {
            ['name'] = '5层经验商店',
            ['menu'] = {
                {
                    ['desc'] = '提升三级',
                    ['trade'] = function()
                        if hero.exp >= 270 then
                            hero.exp = hero.exp - 270
                            hero.level = hero.level + 3
                            hero.hp = hero.hp + 3000
                            hero.attack = hero.attack + 20
                            hero.defense = hero.defense + 20
                            return true
                        end
                        return false
                    end
                },
                {
                    ['desc'] = '增加17点攻击力',
                    ['trade'] = function()
                        if hero.exp >= 95 then
                            hero.exp = hero.exp - 95
                            hero.attack = hero.attack + 17
                            return true
                        end
                        return false
                    end
                },
                {
                    ['desc'] = '增加5点防御力',
                    ['trade'] = function()
                        if hero.exp >= 95 then
                            hero.exp = hero.exp - 95
                            hero.def = hero.def + 17
                            return true
                        end
                        return false
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
end
function Oldman:keypressed(key)
    if self.status <= #self.dialogs and self.page <= #self.dialogs[self.status] then
        if key == 'space' then
            self.page = self.page + 1
            if self.page > #self.dialogs[self.status] then
                self.talking = false
                self.status = self.status + 1
                if self.floorNum == 2 then
                    self.die = true
                    hero.attack = hero.attack + 30
                    hero.refreshMap = true
                    hero.sloganText = '攻击 +30'
                    hero.sloganAlpha = 1
                    hero.focus = nil
                    sound['item']:stop()
                    sound['item']:play()
                elseif self.floorNum == 5 then
                    self.shopping = true
                end
            end
        end
    else
        NPC.keypressed(self, key)
    end
end
return Oldman
