local NPC = require "class.NPC.NPC"
local Theif = Class{__includes = NPC}
function Theif:init(x, y)
    NPC.init(self, x, y, 'Theif', image['C2'], '1-4', 3)
    self.dialogs = {
        {'小偷：2层的门已经打开', '勇士：谢谢'},
        {'小偷：镐头还没有取来', '勇士：我再去找'},
        {'小偷：18层墙已凿开', '勇士：谢谢'}
    }
    self.status = 1
    self.page = 1
end
function Theif:collide()
    if hero.rockPick > 0 then
        self.status = 3
    end
    NPC.collide(self)
end
function Theif:keypressed(key)
    if key == 'space' then
        self.page = self.page + 1
        if self.page > #self.dialogs[self.status] then
            hero.focus = nil
            self.talking = false
            if self.status == 1 then
                floor[2].map[7][2].canOpen = true
                self.status = 2
                sound['item']:stop()
                sound['item']:play()
            elseif self.status == 2 then
                self.page = 1
            elseif self.status == 3 then
                self.die = true
                hero.refreshMap = true
            end
        else
            sound['page']:stop()
            sound['page']:play()
        end
    end
end

return Theif
