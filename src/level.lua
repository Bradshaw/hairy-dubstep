require("tile")
require("useful")
local level_mt = {}
level = {}


function level.new()
	local self = setmetatable({},{__index=level_mt})
	self.map = {}
	for i=1,global.mapsize.x do
		self.map[i]={}
		for j=1,global.mapsize.y do
			self.map[i][j] = tile.new(i,j,useful.tri(math.random()>0.8,tile.types.wall,tile.types.floor))
		end
	end
	return self
end

function level.set(l)
	level.current = l
end

function level.update(dt)
	if level.current then
		level.current:update(dt)
	end
end

function level.draw()
	if level.current then
		level.current:draw()
	end
end

function level.get(x, y)
	return level.current.map[((x-1)%global.mapsize.x)+1][((y-1)%global.mapsize.y)+1]
end

function level.getTile(px, py)
	return level.get(math.floor(px/global.tilesize.x),math.floor(py/global.tilesize.y))
end

function level_mt:update( dt )
	
end

function level_mt:init()
	
end

function level_mt:draw()
	self:doRect(1,1,global.mapsize.x,global.mapsize.y,
		function(m,x,y,t)
			t:draw()
		end
	)
end

function level_mt:doRect(x,y,w,h,func, ...)
	for i=x,x+w do
		for j=y,y+h do
			self:doTile(i,j,func, ...)
		end
	end
end

function level_mt:doTile(x,y,func, ...)
	func(self, x, y, self.map[(x%global.mapsize.x)+1][(y%global.mapsize.y)+1], ...)
end