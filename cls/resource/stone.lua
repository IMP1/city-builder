local base_resource = require 'cls.resource._base'
local stone = {}
setmetatable(stone, base_resource)
stone.__index = stone

function stone.new(x, y, amount)
    local self = base_resource.new("Stone", x, y)
    setmetatable(self, stone)
    self.amount = amount or 75
    return self
end

function stone:draw(tile_size)
    love.graphics.setColor(0.4, 0.4, 0.4)
    love.graphics.circle("fill", (self.x + 0.5) * tile_size, (self.y + 0.5) * tile_size, tile_size / 3)
end

return stone
