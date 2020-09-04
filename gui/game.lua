local Blueprint = require 'cls.blueprint'
-- Buildings
local Carpenter = require 'cls.buildings.carpenter'
local Forge = require 'cls.buildings.forge'
local House = require 'cls.buildings.house'
local Stockpile = require 'cls.buildings.stockpile'

local game_gui = {}
game_gui.__index = game_gui

function game_gui.new(game_object)
    local self = {}
    setmetatable(self, game_gui)
    self.game = game_object
    self.submenu = nil
    return self
end

function game_gui:keyPressed(key)
    if self.submenu and key == "escape" then
        self.submenu = nil
    elseif self.submenu == nil then
        if key == "b" then
            self.submenu = "build"
        elseif key == "t" then
            self.submenu = "technology"
        elseif key == "v" then
            self.submenu = "workers"
        end
    elseif self.submenu == "build" then
        if key == "t" then
            self.game.selection = Blueprint.new(Stockpile)
        elseif key == "h" then
            self.game.selection = Blueprint.new(House)
        elseif key == "f" then
            self.game.selection = Blueprint.new(Forge)
        elseif key == "c" then
            self.game.selection = Blueprint.new(Carpenter)
        end

    end
end

function game_gui:draw(tile_size)    
    local mx, my = love.mouse.getPosition()
    local x, y = self.game.camera:toWorldPosition(mx, my)
    local i, j = math.floor(x / tile_size), math.floor(y / tile_size)
    local obj = (self.game.map.objects[j+1] or {})[i+1]

    if obj then
        local w = math.max(64, love.graphics.getFont():getWidth(obj.name) + 8)
        local h = 64
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 4, 4, w, h)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", 4, 4, w, h)
        love.graphics.printf(obj.name, 4, 4, w, "center")
    end

    do
        local w = 32
        local h = 32
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 4, 128, w, h)
        love.graphics.rectangle("fill", 4, 192, w, h)
        love.graphics.rectangle("fill", 4, 256, w, h)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", 4, 128, w, h)
        love.graphics.printf("B", 4, 128 + 8, 32, "center")
        love.graphics.rectangle("line", 4, 192, w, h)
        love.graphics.printf("T", 4, 192 + 8, 32, "center")
        love.graphics.rectangle("line", 4, 256, w, h)
        love.graphics.printf("V", 4, 256 + 8, 32, "center")
    end

    if self.submenu == "build" then
        love.graphics.setColor(0.8, 0.8, 0.8)
        love.graphics.rectangle("fill", 4, 128, 32, 32)
        love.graphics.setColor(0.2, 0.6, 0.6)
        love.graphics.rectangle("line", 4, 128, 32, 32)
        love.graphics.printf("B", 4, 128 + 8, 32, "center")
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 48, 128, 96, 24)
        love.graphics.rectangle("fill", 48, 160, 96, 24)
        love.graphics.rectangle("fill", 48, 192, 96, 24)
        love.graphics.rectangle("fill", 48, 224, 96, 24)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", 48, 128, 96, 24)
        love.graphics.printf("Stockpile", 48, 128 + 4, 96, "center")
        love.graphics.rectangle("line", 48, 160, 96, 24)
        love.graphics.printf("House", 48, 160 + 4, 96, "center")
        love.graphics.rectangle("line", 48, 192, 96, 24)
        love.graphics.printf("Forge", 48, 192 + 4, 96, "center")
        love.graphics.rectangle("line", 48, 224, 96, 24)
        love.graphics.printf("Carpenter", 48, 224 + 4, 96, "center")
    end
end

return game_gui
