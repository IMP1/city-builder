local scene_manager = require 'lib.scene_manager'

local Map    = require 'cls.map'
local Camera = require 'lib.camera'

local BaseScene = require 'scn._base'
local Scene = {}
setmetatable(Scene, BaseScene)
Scene.__index = Scene

local ROOT_2 = math.sqrt(2)
local TILE_SIZE = 16
local CAMERA_MOVE_SPEED = TILE_SIZE * 16

function Scene.new(map)
    local self = BaseScene.new("Game")
    setmetatable(self, Scene)
    self.map = map
    return self
end

function Scene:load()
    love.graphics.setBackgroundColor(0.125, 0.2, 0.125)
    if self.map == nil then
        self.map = Map.random(50, 50)
    end
    self.camera = Camera.new()
end

function Scene:keyPressed(key)
end

function Scene:mousePressed(mx, my, key)
end

function Scene:update(dt)
    local camera_pan_x = 0
    local camera_pan_y = 0
    if love.keyboard.isDown("w") then
        camera_pan_y = camera_pan_y - 1
    end
    if love.keyboard.isDown("a") then
        camera_pan_x = camera_pan_x - 1
    end
    if love.keyboard.isDown("s") then
        camera_pan_y = camera_pan_y + 1
    end
    if love.keyboard.isDown("d") then
        camera_pan_x = camera_pan_x + 1
    end
    if camera_pan_x ~= 0 and camera_pan_y ~= 0 then
        camera_pan_x = camera_pan_x / ROOT_2
        camera_pan_y = camera_pan_y / ROOT_2
    end
    if camera_pan_x ~= 0 or camera_pan_y ~= 0 then
        self.camera:move(camera_pan_x * CAMERA_MOVE_SPEED * dt, camera_pan_y * CAMERA_MOVE_SPEED * dt)
    end
end

function Scene:draw()
    love.graphics.setColor(1, 1, 1)
    self.camera:set()
    self.map:draw(TILE_SIZE)
    self.camera:unset()
end

return Scene
