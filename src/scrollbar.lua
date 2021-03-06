scrollbar = {}
scrollbar.min = 1
scrollbar.max = global.simlength*global.simrate
scrollbar.xmin = 20
scrollbar.xmax = love.graphics.getWidth()-20
scrollbar.y = love.graphics.getHeight() - 20
scrollbar.playcur = 0
scrollbar.cur = 0
scrollbar.scrubspeed = 0

scrollbar.play = false

function scrollbar.draw()
	local xpos = (scrollbar.cur/scrollbar.max) * (scrollbar.xmax - scrollbar.xmin)
	love.graphics.print(scrollbar.cur/global.simrate,10,10)
	love.graphics.print(scrollbar.cur,10,25)
	love.graphics.rectangle("fill",scrollbar.xmin+xpos-5,scrollbar.y-5,10,10)
	love.graphics.line(scrollbar.xmin,scrollbar.y,scrollbar.xmax,scrollbar.y)
end

function scrollbar.toggle()
	scrollbar.play = not scrollbar.play
end

function scrollbar.update(dt)
	--[[
	if love.mouse.isDown("l") then
		local xm = love.mouse.getX()
		local ym = love.mouse.getY()
		if xm>scrollbar.xmin and xm<scrollbar.xmax and ym>scrollbar.y-15 and ym<scrollbar.y+15 then
			local x = xm - scrollbar.xmin
			x = x/(scrollbar.xmax - scrollbar.xmin)
			x = x * scrollbar.max
			scrollbar.cur = math.floor(x)
			scrollbar.playcur = scrollbar.cur
		end
	end
	--]]
	if love.keyboard.isDown("left") then
		scrollbar.scrubspeed = useful.lerp(scrollbar.scrubspeed,-useful.tri(scrollbar.play,2,1),dt*10)
	elseif love.keyboard.isDown("right") then
		scrollbar.scrubspeed = useful.lerp(scrollbar.scrubspeed,useful.tri(scrollbar.play,2,1),dt*10)
	else
		scrollbar.scrubspeed = useful.lerp(scrollbar.scrubspeed,0,dt*10)
	end
	scrollbar.playcur = scrollbar.playcur + dt * global.simrate * scrollbar.scrubspeed
	scrollbar.cur = math.floor(scrollbar.playcur)

	if scrollbar.play then
		scrollbar.playcur = scrollbar.playcur + dt * global.simrate
		scrollbar.cur = math.floor(scrollbar.playcur)
	end
	scrollbar.playcur = math.max(0,math.min(global.simlength*global.simrate,scrollbar.playcur))
	scrollbar.cur = math.max(0,math.min(global.simlength*global.simrate,scrollbar.cur))
end