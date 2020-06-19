local NPC = require "class.NPC.NPC"
local Fairy = Class{__includes = NPC}
function Fairy:init(x, y)
    NPC.init(self, x, y, 'Fairy', image['C2'], '1-4', 4)
    self.dialogs = {
        {'仙子：给你钥匙', '勇士：谢谢', '仙子：小心怪物'},
        {},
        {'勇士：给你十字架', '仙子：谢谢，给你提升能力'},
    }
end
function Fairy:collide()
    if hero.fairyCross > 0 then
        self.status = 3
    end
    NPC.collide(self)
end
function Fairy:keypressed(key)
    if key == 'space' then
        self.page = self.page + 1
        if self.page > #self.dialogs[self.status] then
            self.talking = false
            hero.focus = nil
            if self.status == 1 then
                self.x = self.x - 1
                hero.yellowKey = hero.yellowKey + 1
                hero.blueKey = hero.blueKey + 1
                hero.redKey = hero.redKey + 1
                hero.refreshMap = true
                hero.sloganText = '黄钥匙 +1 蓝钥匙 +1 红钥匙 +1'
                hero.sloganAlpha = 1
                sound['item']:stop()
                sound['item']:play()
                self.status = 2
                self.page = 1
            elseif self.status == 3 then
                hero.attack = hero.attack + 30
                hero.defense = hero.defense + 30
                hero.sloganText = '攻击 +30 防御 +30'
                hero.sloganAlpha = 1
                sound['item']:stop()
                sound['item']:play()
                self.die = true
            end
        else
            sound['page']:stop()
            sound['page']:play()
        end
    end
end

return Fairy
