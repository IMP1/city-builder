local base_building = require 'cls.buildings._base'

local forge = {}
setmetatable(forge, base_building)
forge.__index = forge

forge.name = "Forge"
forge.width = 4
forge.height = 3

function forge.new(x, y)
    local self = base_building.new(forge.name, x, y, forge.width, forge.height)
    setmetatable(self, forge)
    return self
end

function forge:draw(tile_size)
    love.graphics.setColor(0.6, 0.4, 0.2)
    local x = self.x * tile_size + 4
    local y = self.y * tile_size + 4
    local w = self.width * tile_size - 8
    local h = self.height * tile_size - 8
    love.graphics.rectangle("fill", x, y, w, h)
end

return forge
