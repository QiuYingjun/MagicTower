local Entity = require "class.Entity"
local Door = require "class.Door"
local Item = require "class.Item"
local Enemy = require "class.Enemy"
local NPC = require "class.NPC.NPC"
local Theif = require "class.NPC.Theif"
local Fairy = require "class.NPC.Fairy"
local Robot = require "class.NPC.Robot"
local Oldman = require "class.NPC.Oldman"
local Merchant = require "class.NPC.Merchant"
local keyColors = {"yellowKey", "blueKey", "redKey"}
local gemColors = {"attack", "defense"}
local swordAttack = {10}
function generator(x, y, code, floorNum)
    code = tostring(code)
    local ch1 = code:sub(1, 1)
    local ch2 = code:sub(2, 2)
    local ch3 = code:sub(3, 3)
    if ch1 == 'B' then
        if ch2 == '1' then
            return Entity(x, y, code, image['B1'], quads[tonumber(ch3)])
        elseif ch2 == '2' then
            local e = Entity(x, y, code, image['B2'])
            e.animation = anim8.newAnimation(g('1-4', tonumber(ch3)), 0.25)
            return e
        end
    elseif ch1 == 'C' then
        return generateNPC(x, y, ch2, ch3, floorNum)
    elseif ch1 == 'D' then
        return Door(x, y, tonumber(ch3))
    elseif ch1 == 'F' then
        local e = Entity(x, y, code, image['F1'], quads[tonumber(ch3)])
        e.collide = function()
            local f = floorNum + tonumber(ch3) - 7
            floor[f].curtainAlpha = 1
            sound['item']:stop()
            sound['item']:play()
            Gamestate.switch(floor[f])
        end
        return e
    elseif ch1 == 'I' then
        return generateItem(x, y, ch2, ch3)
    elseif ch1 == 'E' then
        return generateEnemy(x, y, ch2, ch3, floorNum)
    end
    return nil
end

function generateNPC(x, y, ch2, ch3, floorNum)
    local npc = nil
    if ch2 == '2' then
        if ch3 == '1' then
            npc = Oldman(x, y, floorNum)
        elseif ch3 == '2' then
            npc = Merchant(x, y, floorNum)
        elseif ch3 == '3' then
            npc = Theif(x, y)
        elseif ch3 == '4' then
            npc = Fairy(x, y)
        end
    elseif ch2 == '3' then
        npc = NPC(x, y, 'C'..ch2..ch3, image['C'..ch2], tonumber(ch3), 1)
        if ch3 == '2' then
            npc = Robot(x, y, floorNum)
        end
    end
    return npc
end
function generateItem(x, y, ch2, ch3)
    local e = Item(x, y, 'I'..ch2..ch3, image['I'..ch2], quads[tonumber(ch3)])
    if ch2 == '1' then -- 钥匙
        if tonumber(ch3) <= 3 then
            e.bag[keyColors[tonumber(ch3)]] = 1
        else
            for i, keyColor in ipairs(keyColors) do
                e.bag[keyColor] = 1
            end
        end
    elseif ch2 == '2' then -- 药水
        e.bag['hp'] = 300 * tonumber(ch3) - 100
    elseif ch2 == '7' then-- 宝石
        e.bag[gemColors[tonumber(ch3)]] = 3
    elseif ch2 == '4' then-- 剑
        e.bag['attack'] = swordAttack[tonumber(ch3)]
    end
    return e
end
local enemyInfo = {
    ['11'] = {50, 20, 1, 1, 1, '绿头怪'},
    ['12'] = {70, 15, 2, 2, 2, '红头怪'},
    ['13'] = {200, 35, 10, 5, 5, '青头怪'},
    ['14'] = {700, 250, 125, 32, 30, '怪王'},
    ['21'] = {110, 25, 5, 5, 4, '骷髅人'},
    ['22'] = {150, 40, 20, 8, 6, '骷髅士兵'},
    ['23'] = {400, 90, 50, 15, 12, '骷髅队长'},
    ['24'] = {2500, 900, 850, 84, 75, '冥队长'},
    ['31'] = {100, 20, 5, 3, 3, '小蝙蝠'},
    ['32'] = {150, 65, 30, 10, 8, '大蝙蝠'},
    ['33'] = {550, 160, 90, 25, 20, '红蝙蝠'},
    ['41'] = {1200, 620, 520, 65, 75, '双手剑士'},
    ['51'] = {450, 150, 90, 22, 19, '初级卫兵'},
    ['52'] = {1250, 500, 400, 55, 55, '中级卫兵'},
    ['53'] = {1500, 560, 460, 60, 60, '高级卫兵'},
    ['61'] = {125, 50, 25, 10, 7, '初级法师'},
    ['62'] = {100, 200, 110, 30, 25, '高级法师'},
    ['63'] = {250, 120, 70, 20, 17, '麻衣法师', 100},
    ['64'] = {500, 400, 260, 47, 45, '麻衣法师', 300},
    ['71'] = {850, 350, 200, 45, 40, '金卫士'},
    ['72'] = {900, 750, 650, 77, 70, '金队长'},
    ['81'] = {1300, 300, 150, 40, 35, '白衣武士', nil, 1 / 4},
    ['82'] = {15000, 1000, 1000, 100, 100, '红衣魔王'},
    ['83'] = {1500, 830, 730, 80, 70, '灵法师', nil, 1 / 3},
    ['91'] = {300, 75, 45, 13, 10, '兽面人'},
}
function generateEnemy(x, y, ch2, ch3, floorNum)
    local hp, attack, defense, money, exp, name, autoDamage, ratioDamage = unpack(enemyInfo[ch2..ch3] or {0, 0, 0, 0, 0, 'TODO'})
    local e = Enemy(x, y, floorNum, hp, attack, defense, money, exp, name, image['E'..ch2], tonumber(ch3))
    if autoDamage then
        e.autoDamage = autoDamage
    end
    if ratioDamage then
        e.ratioDamage = ratioDamage
    end
    return e
end
