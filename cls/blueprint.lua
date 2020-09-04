local blueprint = {}
blueprint.__index = blueprint

function blueprint.new(building_class)
    local self = {}
    setmetatable(self, blueprint)
    self.building_class = building_class
    self.name = self.building_class.name
    return self
end

function blueprint:draw(tile_size, x, y, w, h)
    local width = self.building_class.width
    if type(self.building_class.width) == "table" then
        width = w or 1
    end
    local height = self.building_class.height
    if type(self.building_class.height) == "table" then
        height = h or 1
    end
    love.graphics.setColor(0.6, 0.6, 1, 0.3)
    love.graphics.rectangle("fill", x * tile_size, y * tile_size, width * tile_size, height * tile_size)

end

return blueprint
