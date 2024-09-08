export type SpringProperties = {Mass : number?, Force : number?, Damping : number?, Speed : number?}

local ITERATIONS = 8
local TARGET_FPS = 60
local ITERATION_INTERVAL = (1 / TARGET_FPS) / ITERATIONS

local RunService = game:GetService("RunService")

local Spring = {}
Spring.__index = Spring

function Spring.new(Properties : SpringProperties?)
	local TypeRefined : SpringProperties = Properties or {}

	local self = setmetatable({
		Target = Vector3.new(),
		Position = Vector3.new(),
		Velocity = Vector3.new(),

		Mass = TypeRefined.Mass or 5,
		Force = TypeRefined.Force or 50,
		Damping	= TypeRefined.Damping or 4,
		Speed = TypeRefined.Speed  or 4,
	}, Spring)

	return self
end

function Spring:Start(Callback : (NewValue : Vector3, DeltaTime : number) -> ()) : RBXScriptConnection
	local Connection

	Connection = RunService.Heartbeat:Connect(function(DeltaTime : number)
		Callback(self:Update(DeltaTime), DeltaTime)

		if self.Velocity.Magnitude < 0.001 then
			Connection:Disconnect()
		end
	end)

	return Connection
end

function Spring:Update(DeltaTime : number) : Vector3
	local IterationsThisFrame = DeltaTime / ITERATION_INTERVAL
	local ScaledDeltaTime = DeltaTime * self.Speed / IterationsThisFrame

	for i = 1, math.round(IterationsThisFrame) do
		local IterationForce = self.Target - self.Position
		local Acceleration = (IterationForce * self.Force) / self.Mass

		Acceleration -= self.Velocity * self.Damping

		self.Velocity += Acceleration * ScaledDeltaTime
		self.Position += self.Velocity * ScaledDeltaTime
	end

	return self.Position
end

return Spring
