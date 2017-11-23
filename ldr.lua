-- Light senor thread

print("LDR thread started!")

require("love.timer")
local GPIO = require("periphery").GPIO

local ldrPin = 21
local ldrGpio

local ldrChannel = love.thread.getChannel("light")

local function readLight(pin)
	local gpio = GPIO(pin, "out")

	gpio:write(false)
	love.timer.sleep(0.1)

	gpio:close()
	gpio = GPIO(pin, "in")

	local reading = 0
	while not gpio:read() do
		reading = reading + 1
	end

	gpio:close()

	return reading	
end

while true do
	local value = readLight(ldrPin)
	--print("Thread val: " .. tostring(value))
	ldrChannel:push(value)
end



