-- Tripwire
print("Video Tripwire")

-- Configuration
local config

function love.load()
	config = dofile("config.lua")
	print("Main video: " .. config.mainVideo)
	print("Trigger video: " .. config.triggerVideo)
end

function love.draw()
	
end

function love.update(dt)
	
end


