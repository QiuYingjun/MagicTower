local NPC = require "class.NPC.NPC"
local Oldman = Class{__includes = NPC}
function Oldman:init(x, y, floorNum)
    NPC.init(self, x, y, 'Oldman', image['C2'], '1-4', 1)
    if floorNum == 2 then
        self.dialogs = {
            {'老人：给你一把剑', '勇士：谢谢'}
        }
    elseif floorNum == 4 then
        self.shop = {}
    elseif floorNum == 14 then
        self.shop = {}
    end
end
function Oldman:keypressed(key)
    if key == 'space' then
        self.page = self.page + 1
        if self.page > #self.dialogs[self.status] then
            self.talking = false
            hero.focus = nil
            if self.status == 1 then
                self.die = true
                hero.attack = hero.attack + 30
                hero.refreshMap = true
                hero.sloganText = '攻击 +30'
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
return Oldman
