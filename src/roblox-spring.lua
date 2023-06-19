local ITERATIONS = 8

local Spring = {}
Spring.__index = Spring

function Spring.new(Mass : number?, Force : number?, Damping : number?, Speed : number?)
	local self = setmetatable({
		Target = Vector3.new(),
		Position = Vector3.new(),
		Velocity = Vector3.new(),

		Mass = Mass or 5,
		Force = Force or 50,
		Damping	= Damping or 4,
		Speed = Speed  or 4,
	}, Spring)
	
	return self
end

function Spring:Shove(Force : Vector3)
	self.Velocity += Force
end

function Spring:Update(DeltaTime : number)
	local ScaledDeltaTime = math.min(DeltaTime, 1) * self.Speed / ITERATIONS

	for i = 1, ITERATIONS do
		local IterationForce = self.Target - self.Position
		local Acceleration = (IterationForce * self.Force) / self.Mass

		Acceleration -= self.Velocity * self.Damping

		self.Velocity += Acceleration * ScaledDeltaTime
		self.Position += self.Velocity * ScaledDeltaTime
	end

	return self.Position
end

return Spring
