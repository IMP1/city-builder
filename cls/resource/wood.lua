local base_resource = require 'cls.resource._base'
local wood = {}
setmetatable(wood, base_resource)
wood.__index = wood

function wood.new(x, y, amount)
    local self = base_resource.new("Wood", x, y)
    setmetatable(self, wood)
    self.amount = amount or 100
    return self
end

function wood:draw(tile_size)
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("fill", (self.x + 0.5) * tile_size, (self.y + 0.5) * tile_size, tile_size / 3)
end

return wood
