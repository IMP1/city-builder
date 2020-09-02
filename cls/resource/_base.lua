local resource = {}
resource.__index = resource

function resource.new(name, x, y)
    local self = {}
    setmetatable(self, resource)
    self.name = name
    self.x = x
    self.y = y
    return self
end

function resource:draw()
    
end

return resource
