local scene_manager = require 'lib.scene_manager'

local Map    = require 'cls.map'
local Camera = require 'lib.camera'
local Gui    = require 'gui.game'

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
    self.blueprints = {}
    self.gui = Gui.new(self)
    self.selection = nil
    self.selection_drag_origin = nil
    self.selection_drag_position = nil
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
    self.gui:keyPressed(key)
end

function Scene:mousePressed(mx, my, key)
    -- TODO: Add check that there is a selection or something to be dragging
    local x, y = self.camera:toWorldPosition(mx, my)
    local i, j = math.floor(x / TILE_SIZE), math.floor(y / TILE_SIZE)
    self.selection_drag_origin = {i, j}
end

function Scene:mouseReleased(mx, my, key)
    -- TODO: If right click then cancel the selection/drag
    local x, y = self.camera:toWorldPosition(mx, my)
    local i, j = math.floor(x / TILE_SIZE), math.floor(y / TILE_SIZE)
    if self.selection and self.selection.building_class then
        x = math.min(self.selection_drag_position[1], self.selection_drag_origin[1])
        y = math.min(self.selection_drag_position[2], self.selection_drag_origin[2])
        local w = math.abs(self.selection_drag_position[1] - self.selection_drag_origin[1]) + 1
        local h = math.abs(self.selection_drag_position[2] - self.selection_drag_origin[2]) + 1
        if self.selection:is_valid(x, y, w, h, self.map) then
            local new_building = self.selection.building_class.new(x, y, w, h)
            table.insert(self.map.buildings, new_building)
            if not love.keyboard.isDown("lshift") then
                self.selection = nil
            end
        end
    end
    self.selection_drag_origin = nil
    self.selection_drag_position = nil
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
    if self.selection_drag_origin then
        local mx, my = love.mouse.getPosition()
        local x, y = self.camera:toWorldPosition(mx, my)
        local i, j = math.floor(x / TILE_SIZE), math.floor(y / TILE_SIZE)
        self.selection_drag_position = {i, j}
    end
end

function Scene:draw()
    local mx, my = love.mouse.getPosition()
    local x, y = self.camera:toWorldPosition(mx, my)
    local i, j = math.floor(x / TILE_SIZE), math.floor(y / TILE_SIZE)
    local obj = (self.map.objects[j+1] or {})[i+1]
    x = i * TILE_SIZE
    y = j * TILE_SIZE

    love.graphics.setColor(1, 1, 1)

    self.camera:set()
    self.map:draw(TILE_SIZE)

    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.rectangle("line", x, y, TILE_SIZE, TILE_SIZE)
    if self.selection then
        if self.selection.building_class then -- It's a blueprint
            local w, h = nil, nil
            if self.selection_drag_position then
                w = math.abs(self.selection_drag_position[1] - self.selection_drag_origin[1]) + 1
                h = math.abs(self.selection_drag_position[2] - self.selection_drag_origin[2]) + 1
                local i = math.min(self.selection_drag_origin[1], self.selection_drag_position[1])
                local j = math.min(self.selection_drag_origin[2], self.selection_drag_position[2])
                self.selection:draw(TILE_SIZE, i, j, w, h, self.map)
            else
                self.selection:draw(TILE_SIZE, i, j, w, h, self.map)
            end
        end
    end
    self.camera:unset()

    self.gui:draw(TILE_SIZE)

end

return Scene
