push = require 'push.push'
anim8 = require 'anim8.anim8'
Gamestate = require 'hump.gamestate'
Class = require 'hump.class'

require 'util'
require 'generator'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    image = {}
    for k, file in ipairs(love.filesystem.getDirectoryItems('assets/img')) do
        if file:sub(-3):lower() == 'png' then
            image[file:sub(1, 2)] = love.graphics.newImage('assets/img/'..file)
        end
    end
    sound = {}
    for k, file in ipairs(love.filesystem.getDirectoryItems('assets/sound')) do
        if file:sub(1, 1) ~= '.' then
            local name = split(file, '.')[1]
            sound[name] = love.audio.newSource('assets/sound/'..file, 'static')
        end
    end
    -- sound = {
    --     ['bgm0'] = love.audio.newSource('assets/sound/bgm0.wav', 'stream'),
    --     ['bgm1'] = love.audio.newSource('assets/sound/bgm1.mp3', 'stream'),
    --     ['bgm2'] = love.audio.newSource('assets/sound/bgm2.mp3', 'stream'),
    --     ['bgm3'] = love.audio.newSource('assets/sound/bgm3.wav', 'stream'),
    --     ['move'] = love.audio.newSource('assets/sound/move.wav', 'static'),
    --     ['page'] = love.audio.newSource('assets/sound/page.wav', 'static'),
    --     ['item'] = love.audio.newSource('assets/sound/item.wav', 'static'),
    --     ['door'] = love.audio.newSource('assets/sound/door.wav', 'static'),
    --     ['fence'] = love.audio.newSource('assets/sound/fence.wav', 'static'),
    --     ['hit'] = love.audio.newSource('assets/sound/hit.wav', 'static'),
    --     ['refuse'] = love.audio.newSource('assets/sound/refuse.wav', 'static'),
    --     ['select'] = love.audio.newSource('assets/sound/select.wav', 'static'),
    -- }
    floor = {
        ['title'] = require "state.title",
        ['story'] = require "state.story",
        ['help'] = require "state.help",
    }
    for k, file in ipairs(love.filesystem.getDirectoryItems('state/floor')) do
        if file:sub(-3):lower() == 'lua' then
            local i = tonumber(file:sub(6, 7))
            floor[i] = require ("state.floor."..file:sub(1, 7))
            floor[i]:init()
        end
    end

    require 'class.Hero'

    hero = Hero(6, 10)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = false,
        canvas = true
    })
    Gamestate.registerEvents()
    Gamestate.switch(floor[2])
end

function love.draw()

end

function love.update(dt)
    blockFPS(MAX_FPS, dt)
end

function love.keypressed(key)

end

function love.resize(w, h)
    -- push:resize(w, h)
end
