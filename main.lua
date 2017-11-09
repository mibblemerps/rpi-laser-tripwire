-- Video Tripwire Project
print("Video Tripwire")

-- Configuration
local config

-- Video streams
local mainVideo, triggerVideo = {}, {}

-- Scales
local mainSx, mainSy
local triggerSx, triggerSy

-- State
local currentVideo
local tripped = false

---

local function getScaleForVideo(video)
	local sx = love.graphics.getWidth() / video:getWidth()
	local sy = love.graphics.getHeight() / video:getHeight()
	
	return sx, sy
end

local function setCurrentVideo(video)
	currentVideo = video
	video.video:rewind()
	video.video:play()
end

---

function love.load()
	config = dofile("config.lua")
	
	-- Setup the window
	love.window.setFullscreen(config.fullscreen)
	love.window.setTitle("Video Tripwire")
	love.mouse.setVisible(false)
	
	-- Load video streams
	print("Loading main video ('" .. config.mainVideo .. "')")
	mainVideo.video = love.graphics.newVideo(config.mainVideo, config.loadAudio)
	
	print("Loading trigger video ('" .. config.triggerVideo .. "')")
	triggerVideo.video = love.graphics.newVideo(config.triggerVideo, config.loadAudio)
	
	-- Calculate scales
	mainVideo.sx, mainVideo.sy = getScaleForVideo(mainVideo.video)
	triggerVideo.sx, triggerVideo.sy = getScaleForVideo(triggerVideo.video)
	
	
	setCurrentVideo(triggerVideo)
end

function love.draw()
	-- Draw video
	love.graphics.draw(currentVideo.video, 0, 0, 0, currentVideo.sx, currentVideo.sy)
	
	if not currentVideo.video:isPlaying() then
		if tripped and (currentVideo == mainVideo) then
			-- Tripwire tripped and we're playing the main video, switch to the trigger video
			
		elseif currentVideo == triggerVideo then
			-- We're playing the trigger video - don't repeat and switch back to the main video
			setCurrentVideo(mainVideo)
		end
	end
end

function love.update(dt)
	
end

