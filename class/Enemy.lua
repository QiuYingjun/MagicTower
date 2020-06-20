local Entity = require "class.Entity"
local Enemy = Class{__includes = Entity}
function Enemy:init(x, y, floorNum, hp, attack, defense, money, exp, name, image, row)
    Entity.init(self, x, y, 'E', image)
    self.name = name
    self.x = x
    self.y = y
    self.hp = hp
    self.attack = attack
    self.defense = defense
    self.autoDamage = 0
    self.exp = exp
    self.money = money
    self.ratioDamage = 0

    self.animation = anim8.newAnimation(g('1-4', row), 0.25)
end

function Enemy:collide()
    print(self:getDamage())
    if self:getDamage() < hero.hp then
        self.die = true
        hero.x = self.x
        hero.y = self.y
        hero.hp = hero.hp - self:getDamage()
        hero.money = hero.money + self.money
        hero.exp = hero.exp + self.exp
        hero.refreshMap = true
        sound['hit']:stop()
        sound['hit']:play()
        return '金币 +'..self.money..' '..'经验 +'..self.exp
    else
        sound['refuse']:play()
    end
end

function Enemy:getDamage()
    if hero.attack <= self.defense then
        return 1 / 0
    end
    local count = math.ceil(self.hp / (hero.attack - self.defense))
    return math.max(0, self.autoDamage + self.ratioDamage * hero.hp + (count - 1) * (self.attack - hero.defense))
end
return Enemy
