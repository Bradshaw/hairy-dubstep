local tracked_mt = {}
tracked = {}

function tracked.new(dat, originalState)
	local self = setmetatable({},{__index=tracked_mt})
	self.originalState = originalState
	for k,v in pairs(dat) do
		self[k] = v
	end
	self.log = {}
	return self
end

function tracked_mt:init()
	self.log[1] = self.originalState
end

function tracked_mt:get(frame)
	frame = math.max(1, frame)
	if #self.log==0 then
		self:init()
	end
	while #self.log<frame do
		self:next()
	end
	return self.log[frame]
end

function tracked_mt:doToCur(...)
	self:doTo(scrollbar.cur, ...)
end

function tracked_mt:doTo(frame, func, ...)
	frame = math.max(1, frame)
	for i=#self.log,frame+1,-1 do
		self.log[i] = nil
	end
	func(self.log[frame], ...)
end

function tracked_mt:next()
	self.log[#self.log+1] = self:sim(self.log[#self.log])
end

function tracked_mt:sim(st)
	return st
end

function tracked_mt:draw()

end