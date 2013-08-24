local state = gstate.new()


function state:init()

end


function state:enter()
	l = level.new(10,10)
	d = dude.new(100,100)
	level.set(l)
end


function state:focus()

end


function state:mousepressed(x, y, btn)
	d:doToCur(function(self, ... )
		self.tx = x
		self.ty = y
	end)
end


function state:mousereleased(x, y, btn)
	
end


function state:joystickpressed(joystick, button)
	
end


function state:joystickreleased(joystick, button)
	
end


function state:quit()
	
end


function state:keypressed(key, uni)
	if key=="escape" then
		love.event.push("quit")
	end
	if key==" " then
		scrollbar.toggle()
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	level.update(dt)
	scrollbar.update(dt)
end


function state:draw()
	--level.draw()
	d:draw()
	scrollbar.draw()
end

return state