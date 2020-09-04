local base_building = require 'cls.buildings._base'

local stockpile = {}
setmetatable(stockpile, base_building)
stockpile.__index = stockpile

stockpile.name = "Stockpile"
stockpile.width = {1, 10}
stockpile.height = {1, 10}

function stockpile.new(x, y, w, h)
    local self = base_building.new(stockpile.name, x, y, w, h)
    setmetatable(self, stockpile)
    return self
end

function stockpile:draw(tile_size)
    love.graphics.setColor(0.6, 0.4, 0.2)
    local x = self.x * tile_size + 4
    local y = self.y * tile_size + 4
    local w = self.width * tile_size - 8
    local h = self.height * tile_size - 8
    love.graphics.rectangle("fill", x, y, w, h)
end

return stockpile
