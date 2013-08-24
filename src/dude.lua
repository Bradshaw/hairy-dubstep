require("tracked")

dude = {}


function dude.new(x,y)

	local originalState = {
		x = x,
		y = y,
		sx = 0,
		sy = 0,
		tx = x,
		ty = y
	}
	local dat = {}
	dat.acc = 0.1
	dat.fric = 0.2
	dat.mult = 3
	dat.sim = dude.sim
	dat.draw = dude.draw

	return tracked.new(dat, originalState)

end

function dude.sim(self, st)
	local s = useful.clone(st)
	if s.x~=s.tx or s.y~=s.ty then
		local dx = s.tx-s.x
		local dy = s.ty-s.y
		local d = math.sqrt(dx*dx+dy*dy)
		if d>8 then
			local nx = dx/d
			local ny = dy/d
			s.sx = s.sx+nx*self.acc
			s.sy = s.sy+ny*self.acc
		end
		s.sx = s.sx-s.sx*self.fric
		s.sy = s.sy-s.sy*self.fric
		s.x = s.x+s.sx*self.mult
		s.y = s.y+s.sy*self.mult
	end
	return s
end

function dude.draw(self)
	local st = self:get(scrollbar.cur)
	love.graphics.rectangle("fill",st.x-3,st.y-3,6,6)
	love.graphics.circle("line",st.tx,st.ty,8)
end