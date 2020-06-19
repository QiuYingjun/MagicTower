WINDOW_WIDTH = 576 * 2
WINDOW_HEIGHT = 416 * 2
VIRTUAL_WIDTH = 576
VIRTUAL_HEIGHT = 416
DIR_UP = 0
DIR_RIGHT = 1
DIR_DOWN = 2
DIR_LEFT = 3
X0 = 6
Y0 = 1
WIDTH = 32
HEIGHT = 32
MAP_SIZE = 11
MAX_FPS = 30
FONT_BIG = love.graphics.newFont("assets/方正像素24.TTF", WIDTH * 2)
FONT_MIDIUM = love.graphics.newFont("assets/方正像素24.TTF", WIDTH * 1)
FONT_SMALL = love.graphics.newFont("assets/方正像素24.TTF", WIDTH * 0.5)
FONT_MICRO = love.graphics.newFont("assets/方正像素24.TTF", WIDTH * 0.3)
quads = {}
for y = 0, 3 do
    for x = 0, 3 do
        table.insert(quads, love.graphics.newQuad(
            WIDTH * x, HEIGHT * y,
            WIDTH, HEIGHT,
            WIDTH * 4, HEIGHT * 4
        ))
    end
end
g = anim8.newGrid(WIDTH, HEIGHT, WIDTH * 4, HEIGHT * 4)

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(FONT_MICRO)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

function blockFPS(limit, dt) -- Call this function in love.update
    if dt < 2 / limit then
        love.timer.sleep(2 / limit - dt)
    end
end
function split(s, sep)
    local fields = {}

    local sep = sep or " "
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

    return fields
end
