require "classes.Player"

local game = {
    entities = {
        Player()
    },
    keymap = {
        a = function()
            Signal.emit("move", "left")
        end,
        d = function()
            Signal.emit("move", "right")
        end,
        space = function()
            Signal.emit("jump")
        end,
        escape = function()
            love.event.quit()
        end
    }
}

function game:init()

end

function game:enter()

end

function game:update(dt)
    for k, v in pairs(game.keymap) do
        if love.keyboard.isDown(k) then
            v()
        end
    end
    for _, entity in ipairs(game.entities) do
        entity:update(dt)
    end
end

function game:keypressed(key, code, isRepeat)
end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
    for _, entity in ipairs(game.entities) do
        entity:draw()
    end
end

return game
