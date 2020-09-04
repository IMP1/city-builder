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

function building:contains_point(x, y)
    if x < self.x then return false end
    if y < self.y then return false end
    if x > self.x + self.width - 1 then return false end
    if y > self.y + self.height - 1 then return false end
    return true
end

return building
