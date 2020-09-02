local base_resource = require 'cls.resource._base'
local ore = {}
setmetatable(ore, base_resource)
ore.__index = ore

function ore.new(x, y, amount)
    local self = base_resource.new("Ore", x, y)
    setmetatable(self, ore)
    self.amount = amount or 80
    return self
end

function ore:draw(tile_size)
    love.graphics.setColor(0.3, 0.3, 0.5)
    love.graphics.circle("fill", (self.x + 0.5) * tile_size, (self.y + 0.5) * tile_size, tile_size / 3)
end

return ore
