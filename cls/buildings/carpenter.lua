local base_building = require 'cls.buildings._base'

local carpenter = {}
setmetatable(carpenter, base_building)
carpenter.__index = carpenter

carpenter.name = "Carpenter"
carpenter.width = 3
carpenter.height = 3

function carpenter.new(x, y)
    local self = base_building.new(carpenter.name, x, y, carpenter.width, carpenter.height)
    setmetatable(self, carpenter)
    return self
end

function carpenter:draw(tile_size)
    love.graphics.setColor(0.6, 0.4, 0.2)
    local x = self.x * tile_size + 4
    local y = self.y * tile_size + 4
    local w = self.width * tile_size - 8
    local h = self.height * tile_size - 8
    love.graphics.rectangle("fill", x, y, w, h)
end

return carpenter
