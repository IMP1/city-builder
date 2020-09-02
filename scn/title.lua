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
end

function Scene:keyPressed(key)
end

function Scene:mousePressed()
end

function Scene:draw()
end

return Scene
