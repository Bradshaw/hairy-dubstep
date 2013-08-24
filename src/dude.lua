local dude_mt = {}
dude = {}

function dude.new(x, y)
	local self = setmetatable({},{__index=dude_mt})
	self.originalState = {
		x = x,
		y = y,
		sx = 0,
		sy = 0,
		tx = x,
		ty = y
	}
	self.acc = 0.1
	self.fric = 0.2
	self.mult = 3
	self.log = {}
	return self
end

function dude_mt:init()
	self.log[1] = self.originalState
end

function dude_mt:get(frame)
	frame = math.max(1, frame)
	if #self.log==0 then
		self:init()
	end
	while #self.log<frame do
		self:next()
	end
	return self.log[frame]
end

function dude_mt:doToCur(...)
	self:doTo(scrollbar.cur, ...)
end

function dude_mt:doTo(frame, func, ...)
	for i=#self.log,frame+1,-1 do
		self.log[i] = nil
	end
	func(self.log[frame], ...)
end

function dude_mt:next()
	self.log[#self.log+1] = self:sim(self.log[#self.log])
end

function dude_mt:sim(st)
	local s = useful.clone(st)
	if s.x~=s.tx or s.y~=s.ty then
		local dx = s.tx-s.x
		local dy = s.ty-s.y
		local d = math.sqrt(dx*dx+dy*dy)
		local nx = dx/d
		local ny = dy/d
		s.sx = s.sx+nx*self.acc
		s.sy = s.sy+ny*self.acc
		s.sx = s.sx-s.sx*self.fric
		s.sy = s.sy-s.sy*self.fric
		s.x = s.x+s.sx*self.mult
		s.y = s.y+s.sy*self.mult
	end
	return s
end

function dude_mt:draw()
	local st = self:get(scrollbar.cur)
	love.graphics.rectangle("fill",st.x-3,st.y-3,6,6)
	love.graphics.circle("line",st.tx,st.ty,8)
	love.graphics.print(st.x.." "..st.y,10,50)
end