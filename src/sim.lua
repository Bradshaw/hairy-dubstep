local sim_mt = {}
sim = {}

function sim.new(state)
	local self = setmetatable({},{__index=sim_mt})
	self.state = state
	self.lastgood = 1
	self.events = {}
	self.states = {}
	self.states[1] = state.init()
	return self
end

function sim_mt:simulate(frame)
	for i=lastgood,math.max(1,math.min(global.simlength*global.simrate, frame)) do
		self.frame[i] = self.track.simulate()
	end
end