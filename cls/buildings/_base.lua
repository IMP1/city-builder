local building = {}
building.__index = building

function building.new(name, x, y, width, height)
    local self = {}
    setmetatable(self, building)
    self.name = name
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.completion = 0
    return self
end

function building:draw()
    -- STUB
end

return building
