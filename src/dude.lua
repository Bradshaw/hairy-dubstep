require("tracked")

dude = {}

dude.im = love.graphics.newImage("images/terrorriste_marche_spritecheet.png")
dude.anims = {}
dude.anims.left = {}
dude.anims.right = {}
dude.anims.up = {}
dude.anims.down = {}

dude.framelength = 10

for i=1,4 do
	dude.anims.left[i] = love.graphics.newQuad((i-1)*50, 60, 50, 60, 200, 240)
	dude.anims.right[i] = love.graphics.newQuad((i-1)*50, 0, 50, 60, 200, 240)
	dude.anims.up[i] = love.graphics.newQuad((i-1)*50, 180, 50, 60, 200, 240)
	dude.anims.down[i]  = love.graphics.newQuad((i-1)*50, 120, 50, 60, 200, 240)
end



function dude.new(x,y)

	local originalState = {
		x = x,
		y = y,
		sx = 0,
		sy = 0,
		tx = x,
		ty = y,
		frame = 1,
		framecooldown = 10,
		anim = dude.anims.down
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
	local direction = "none"
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
		if s.sx>math.abs(s.sy) then
			direction = "right"
		elseif s.sx<-math.abs(s.sy) then
			direction = "left"
		elseif s.sy>math.abs(s.sx) then
			direction = "down"
		elseif s.sy<-math.abs(s.sx) then
			direction = "up"
		end
		s.anim = dude.anims[direction]
		if level.getTile(s.x,s.y).collide then
			s.x = st.x
			s.y = st.y
			s.sx = s.sx-s.sx*self.fric
			s.sy = s.sy-s.sy*self.fric
		end
	end

	local spd = math.sqrt(s.sx*s.sx+s.sy*s.sy)

	s.framecooldown = s.framecooldown-spd*2
	if s.framecooldown<=0 then
		s.framecooldown = dude.framelength
		s.frame = s.frame+1
		if s.frame >=5 then
			s.frame = 1
		end
	end
	if spd<0.1 then
		s.frame = 1
	end


	return s
end

function dude.draw(self)
	local st = self:get(scrollbar.cur)
	--love.graphics.rectangle("fill",st.x-3,st.y-3,6,6)
	love.graphics.circle("line",st.tx,st.ty,8)
	love.graphics.drawq(dude.im, st.anim[st.frame], st.x, st.y, 0, 1, 1, 25, 57)
end