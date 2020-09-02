local scene_manager = require 'lib.scene_manager'

local BaseScene = require 'scn._base'
local Scene = {}
setmetatable(Scene, BaseScene)
Scene.__index = Scene

function Scene.new()
    local self = BaseScene.new("Title")
    setmetatable(self, Scene)
    return self
end

function Scene:load()
    love.graphics.setBackgroundColor(0.125, 0.125, 0.2)
end

function Scene:keyPressed(key)
    local nextScene = require 'scn.game'
    scene_manager.pushScene(nextScene.new())
end

function Scene:mousePressed(mx, my, key)
end

function Scene:draw()
end

return Scene
