local stator_mt = {}
stator = {}

function stator.new()
	self = setmetatable({},{__index=stator_mt})

	return self
end



function stator_mt:init()
	return {}
end



function stator_mt:sim(prev, events)
	s2 = setmetatable({},{__index=prev})
	for _,event in ipairs(event) do
		s2 = s2.apply(event)
	end
	return s2.next()
end


function stator_mt:apply(st, ev)

end


function stator_mt:next()

end