local base_building = require 'cls.buildings._base'

local house = {}
setmetatable(house, base_building)
house.__index = house

house.name = "House"
house.width = 2
house.height = 2

function house.new(x, y)
    local self = base_building.new(house.name, x, y, house.width, house.height)
    setmetatable(self, house)
    return self
end

function house:draw(tile_size)
    love.graphics.setColor(0.6, 0.4, 0.2)
    local x = self.x * tile_size + 4
    local y = self.y * tile_size + 4
    local w = self.width * tile_size - 8
    local h = self.height * tile_size - 8
    love.graphics.rectangle("fill", x, y, w, h)
end

return house
