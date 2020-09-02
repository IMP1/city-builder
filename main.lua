local scene_manager = require 'lib.scene_manager'

function T(str)
    return str
end

DEBUG = true

function love.load()
    love.graphics.setBackgroundColor(34/255,32/255,52/255)
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
    local Scene = require 'scn.title'
    scene_manager.hook()
    scene_manager.setScene(Scene.new())
end

function love.keypressed(key)
    if DEBUG then
        if key == "escape" then love.event.quit() end
    end
    if key == "`" then DEBUG = not DEBUG end
end

function love.update(dt)
    scene_manager.update(dt)
end

function love.draw()
    scene_manager.draw()
end
