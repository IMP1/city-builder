local blueprint = {}
blueprint.__index = blueprint

function blueprint.new(building_class)
    local self = {}
    setmetatable(self, blueprint)
    self.building_class = building_class
    self.name = self.building_class.name
    return self
end

function blueprint:is_valid(x, y, width, height, map)
    if type(self.building_class.width) == "table" then
        if width < self.building_class.width[1] or width > self.building_class.width[2] then
            return false
        end
    end
    if type(self.building_class.height) == "table" then
        if height < self.building_class.height[1] or height > self.building_class.height[2] then
            return false
        end
    end
    local width = self.building_class.width
    if type(self.building_class.width) == "table" then
        width = w or 1
    end
    local height = self.building_class.height
    if type(self.building_class.height) == "table" then
        height = h or 1
    end
    for j = y, y + height - 1 do
        for i = x, x + width - 1 do
            if (map.terrain[j+1] or {})[i+1] == 1 then -- water
                return false
            end
            -- TODO: Add other non-buildable terrains
            for _, building in pairs(map.buildings) do
                if building:contains_point(i, j) then
                    return false
                end
            end
        end
    end
    return true
end

function blueprint:draw(tile_size, x, y, w, h, map)
    local width = self.building_class.width
    if type(self.building_class.width) == "table" then
        width = w or 1
    end
    local height = self.building_class.height
    if type(self.building_class.height) == "table" then
        height = h or 1
    end
    local valid = self:is_valid(x, y, width, height, map)
    if valid then
        love.graphics.setColor(0.6, 0.6, 1, 0.3)
    else
        love.graphics.setColor(1, 0.3, 0.3, 0.3)
    end
    love.graphics.rectangle("fill", x * tile_size, y * tile_size, width * tile_size, height * tile_size)

end

return blueprint
