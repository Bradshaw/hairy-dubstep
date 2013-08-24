require("global")

local tile_mt = {}
tile = {}

function tile.new(x,y,from)
	local self = setmetatable({},{__index=from or tile_mt})
	self.x = x or 0
	self.y = y or 0
	return self
end

function tile_mt:draw()
	love.graphics.rectangle("fill", self.x*global.tilesize.x, self.y*global.tilesize.y, global.tilesize.x-2, global.tilesize.y-2)
end

tile.types = {}
tile.types.wall = tile.new()
tile.types.floor = tile.new()
tile.types.floor.draw = function() end