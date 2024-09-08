# roblox-spring
Approximated Spring Module for Roblox

## Docs
|Method Name|Parameters|Returns|
|--|--|--|
|Start|Callback : (Position : Vector3, DeltaTime : number) -> ()|RBXScriptConnection|
|Update|DeltaTime : number|Vector3|

|Function Name|Parameters|Returns|
|--|--|--|
|new|SpringProperties : {Mass : number?, Force : number?, Damping : number?, Speed : number?}?|typeof(SpringModule.new())

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
- ``Spring.Target`` is the "origin" of the spring. If this property is changed, the spring will gravitate towards the new position
- ``Spring.Force`` is how much force is applied to get to the destination
- ``Spring.Speed`` is how fast the spring is simulated
- ``Spring.Damping`` is how much force is applied in the inverse direction of the spring's velocity

All the spring's properties are able to be changed during simulation safely

## Example
```luau
local SpringModule = require(SpringModule)
local Spring = SpringModule.new()

local Part = workspace.Index.To.Part

local Connection : RBXScriptConnection = Spring:Start(function(NewPosition : Vector3, DeltaTime : number)
    Part.Position = NewPosition
end)

while true do
    Spring.Target = Random.new():NextUnitVector() * math.random() * 20

    task.wait(1)
end
```
