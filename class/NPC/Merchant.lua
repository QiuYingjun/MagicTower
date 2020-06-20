local NPC = require "class.NPC.NPC"
local Merchant = Class{__includes = NPC}
function Merchant:init(x, y, floorNum)
    NPC.init(self, x, y, 'Merchant', image['C2'], '1-4', 2)
    self.floorNum = floorNum
    if self.floorNum == 2 then
        self.dialogs = {
            {'商人：给你一把盾', '勇士：谢谢'}
        }
    elseif self.floorNum == 5 then
        self.dialogs = {
            { '商人：相信你一定有特殊的需要，只要你有金币，我就可以帮你' }
        }
        self.shop = {
            ['name'] = '5层钥匙商店',
            ['menu'] = {
                {
                    ['desc'] = '购买1把黄钥匙',
                    ['trade'] = function()
                        if hero.money >= 10 then
                            hero.money = hero.money - 10
                            hero.yellowKey = hero.yellowKey + 1
                            return true
                        end
                        return false
                    end
                },
                {
                    ['desc'] = '购买1把蓝钥匙',
                    ['trade'] = function()
                        if hero.money >= 50 then
                            hero.money = hero.money - 50
                            hero.blueKey = hero.blueKey + 1
                            return true
                        end
                        return false
                    end
                },
                {
                    ['desc'] = '购买1把红钥匙',
                    ['trade'] = function()
                        if hero.money >= 100 then
                            hero.money = hero.money - 100
                            hero.redKey = hero.redKey + 1
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
    elseif self.floorNum == 14 then
        self.shop = {}
    end
end
function Merchant:keypressed(key)
    if self.status <= #self.dialogs and self.page <= #self.dialogs[self.status] then
        if key == 'space' then
            self.page = self.page + 1
            if self.page > #self.dialogs[self.status] then
                self.talking = false
                self.status = self.status + 1
                if self.floorNum == 2 then
                    self.die = true
                    hero.defense = hero.defense + 30
                    hero.refreshMap = true
                    hero.sloganText = '防御 +30'
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
return Merchant
