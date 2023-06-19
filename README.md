# roblox-spring
Approximated Spring Module for Roblox

## Docs
|Method Name|Parameters|Returns|
|--|--|--|
|Shove|Force : Vector3|nil|
|Update|DeltaTime : number|Vector3|

|Function Name|Parameters|Returns|
|--|--|--|
|new|Mass : number?, Force : number?, Damping : number?, Speed : number?|typeof(SpringModule.new())

|Property Name|Type|
|--|--|
|Target|Vector3|
|Position|Vector3|
|Velocity|Vector3|
|Mass|number|
|Force|number|
|Damping|number|
|Speed|number|

## Notes
``Spring.Target`` is the "origin" of the spring. If this property is changed, the spring will gravitate towards the new position
``Spring.Force`` is how much force is applied to get to the destination
``Spring.Speed`` is how fast the spring is simulated

## Example
```lua
local RunService = game:GetService("RunService")

local SpringModule = require(SpringModule)

local Spring = SpringModule.new()

RunService.RenderStepped:Connect(function(DeltaTime)
  local UpdatedPosition : Vector3 = Spring:Update(DeltaTime)
end)
```
