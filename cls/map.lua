local terrain = {
    grass = 0,
    water = 1,
    stone = 2,
}

local resources = {
    none = 0,
    wood = 1,
    stone = 2,
    ore = 3,
}

local resource_classes = {
    wood = require 'cls.resource.wood',
    stone = require 'cls.resource.stone',
    ore = require 'cls.resource.ore',
}

local map = {}
map.__index = map

function map.new()
    local self = {}
    setmetatable(self, map)
    self.terrain = {}
    self.objects = {}
    self.buildings = {}
    return self
end

function map.random(width, height)
    local m = map.new()
    m.terrain = love.filesystem.load("map/test_terrain.lua")()
    local objects = love.filesystem.load("map/test_resources.lua")()
    for j, row in ipairs(objects) do
        m.objects[j] = {}
        for i, tile in ipairs(row) do
            m.objects[j][i] = nil
            if tile == resources.wood then
                m.objects[j][i] = resource_classes.wood.new(i - 1, j - 1)
            elseif tile == resources.stone then
                m.objects[j][i] = resource_classes.stone.new(i - 1, j - 1)
            elseif tile == resources.ore then
                m.objects[j][i] = resource_classes.ore.new(i - 1, j - 1)
            end
        end
    end
    return m
end

function map:draw(tile_size)
    for j, row in pairs(self.terrain) do
        for i, tile in pairs(row) do
            if tile == terrain.grass then
                love.graphics.setColor(0.125, 0.3, 0.125)
            elseif tile == terrain.water then
                love.graphics.setColor(0.125, 0.125, 0.3)
            elseif tile == terrain.stone then
                love.graphics.setColor(0.3, 0.3, 0.3)
            end
            love.graphics.rectangle("fill", (i-1) * tile_size, (j-1) * tile_size, tile_size, tile_size)
        end
    end
    for j, row in pairs(self.objects) do
        for i, object in pairs(row) do
            if object then
                object:draw(tile_size)
            end
        end
    end
    for _, building in pairs(self.buildings) do
        building:draw(tile_size)
    end
end

return map
