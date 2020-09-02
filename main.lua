local scene_manager = require 'lib.scene_manager'

function T(str)
    return str
end

DEBUG = true

function love.load()
    love.graphics.setBackgroundColor(0.125, 0.125, 0.2)
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
    local Scene = require 'scn.title'
    scene_manager.hook()
    scene_manager.setScene(Scene.new())
end

function love.keypressed(key)
    if DEBUG then
        if key == "q" and love.keyboard.isDown("lctrl") then love.event.quit() end
    end
    if key == "`" then DEBUG = not DEBUG end
end

function love.update(dt)
    scene_manager.update(dt)
end

function love.draw()
    scene_manager.draw()
    if DEBUG then
        local WIDTH = love.graphics.getWidth()
        local HEIGHT = love.graphics.getHeight()
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Untitled City-Builder v0.0.0", 0, HEIGHT - 16, WIDTH, "center")
        love.graphics.printf("Scene: " .. scene_manager.scene().name, 0, HEIGHT - 16, WIDTH, "left")
    end
end
