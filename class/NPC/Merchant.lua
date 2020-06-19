local NPC = require "class.NPC.NPC"
local Merchant = Class{__includes = NPC}
function Merchant:init(x, y, floorNum)
    NPC.init(self, x, y, 'Merchant', image['C2'], '1-4', 2)
    if floorNum == 2 then
        self.dialogs = {
            {'商人：给你一把盾', '勇士：谢谢'}
        }
    elseif floorNum == 4 then
        self.shop = {}
    elseif floorNum == 14 then
        self.shop = {}
    end
end
function Merchant:keypressed(key)
    if key == 'space' then
        self.page = self.page + 1
        if self.page > #self.dialogs[self.status] then
            self.talking = false
            hero.focus = nil
            if self.status == 1 then
                self.die = true
                hero.attack = hero.defense + 30
                hero.refreshMap = true
                hero.sloganText = '防御 +30'
                hero.sloganAlpha = 1
                sound['item']:stop()
                sound['item']:play()
            end
        else
            sound['page']:stop()
            sound['page']:play()
        end
    end
end
return Merchant
