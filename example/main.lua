--rename nbpoints
--ondulation confettis

--doc github et host github
--faire une vidéo
--préparer des screenshot et une icône

local SimpleTrail = require "plugin.SimpleTrail"

local currentView = nil--the display objet which contains the different examples of this demo

-----------------------------------
--EXAMPLE 1 :  simple colored trail
-----------------------------------
local function initView1(event)
	if currentView then
		currentView:removeSelf()
	end
	local viewDisplayGroup = display.newGroup()
	currentView = viewDisplayGroup

	local ground = display.newRect(viewDisplayGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, 40)
	ground:setFillColor(0.5,1,0.5)
	local paint = {
		type = "gradient",
		color1 = { 1, 1, 1, 0.25 },
		color2 = { 1, 1, 1, 0 },
		direction = "down"
	} 
	ground.fill = paint
	ground.anchorY = 0

	local SPRITE_SHEET_DATA =
	{
		width = 928/4,
		height = 928/4,
		numFrames = 16,
	}
	local spriteSheet = graphics.newImageSheet("dragon_walk.png", SPRITE_SHEET_DATA)
	local sequence_sprite =
	{
		{
			name = "normalRun",
			start = 1,
			count = 16,
			time = 500,
			loopCount = 0,
			loopDirection = "forward",
			sheet = spriteSheet,
		},
	}

	local sprite1 = display.newSprite(viewDisplayGroup, spriteSheet, sequence_sprite)
	sprite1.xScale = 0.2
	sprite1.yScale = 0.2
	sprite1.x = display.contentCenterX
	sprite1.y = display.contentCenterY - 100
	sprite1:play()
	sprite1.accX = 2
	sprite1.accY = 0

	local trailSprite1 = SimpleTrail.newTrail()
	trailSprite1.width = 15
	trailSprite1:setFillColor(1,0,1)
	trailSprite1.offsetY = 1

	local COLORS = 
	{
		{1,0,0},
		{1,0.5,0},
		{1,1,0},
		{0,1,0},
		{0,0,1},
		{1,0,1},
	}
	local currentColor = 1

	--update listener
	viewDisplayGroup.onEnterFrame = function(event)
		sprite1.accY = sprite1.accY + 0.2

		sprite1.x = sprite1.x + sprite1.accX
		sprite1.y = sprite1.y + sprite1.accY
		if sprite1.y + 20 > display.contentCenterY then
			sprite1.y = display.contentCenterY - 20
			sprite1.accY = -5

			local newColor = COLORS[currentColor]
			currentColor = currentColor + 1
			if currentColor > #COLORS then
				currentColor = 1
			end
			transition.to(trailSprite1, {time = 500, color_r = newColor[1], color_g = newColor[2], color_b = newColor[3]})
		end

		if sprite1.x + 20 > display.contentCenterX + display.actualContentWidth/2 then
			sprite1.x = display.contentCenterX + display.actualContentWidth/2 - 20
			sprite1.accX = -2
			sprite1.xScale = -0.2
		end

		if sprite1.x - 20 < display.contentCenterX - display.actualContentWidth/2 then
			sprite1.x = display.contentCenterX - display.actualContentWidth/2 + 20
			sprite1.accX = 2
			sprite1.xScale = 0.2
		end

		trailSprite1:update(sprite1)
		sprite1:toFront()
	end
end

-------------------------
--EXAMPLE 2 : trail touch
-------------------------
local function initView2(event)
	if currentView then
		currentView:removeSelf()
	end
	local viewDisplayGroup = display.newGroup()
	currentView = viewDisplayGroup

	local title = display.newText(viewDisplayGroup, "Touch to start drawing", display.contentCenterX, 80, native.systemFont, 20)
	title:setFillColor(0)

	local touchObject = display.newCircle(viewDisplayGroup, display.contentCenterX, display.contentCenterY, 15)
	touchObject.isVisible = false
	local trailTouch = SimpleTrail.newTrail({tex = "trail_touch.png", numPoints = 20, width = 18, widthFinal = 0, sharp = true})

	--touch listener
	viewDisplayGroup.onTouch = function(event)
		if event.phase == "began" then
			trailTouch.clear()
			title.isVisible = false
		elseif event.phase == "ended" then
			title.isVisible = true
		end
		touchObject.x = event.x
		touchObject.y = event.y
	end

	--update listener
	viewDisplayGroup.onEnterFrame = function(event)
		trailTouch:update(touchObject)
	end
end

---------------------------------
--EXAMPLE 3 : particles fireworks
---------------------------------
local function initView3(event)
	if currentView then
		currentView:removeSelf()
	end
	local viewDisplayGroup = display.newGroup()
	currentView = viewDisplayGroup
	
	local particles = {}
	local timerSpawnPart = 0

	--update listener
	viewDisplayGroup.onEnterFrame = function(event)
		--update particles
		timerSpawnPart = timerSpawnPart - 1
		if timerSpawnPart <= 0 then
			timerSpawnPart = 20
			local x,y = math.random(25,320-25), math.random(25,200)

			local nbPart = 7
			local beta = math.random()*2*math.pi
			for i=0,nbPart-1 do
				local t = display.newCircle(viewDisplayGroup, x, y, 5)
				t.vx = math.cos(math.pi*2/nbPart * i + beta)
				t.vy = math.sin(math.pi*2/nbPart * i + beta)
				t.speed = math.random() * 1 + 4
				t.lifeTime = 20
				particles[#particles+1] = t

				local color = {1,0,0}
				if i == 0 then
					color = {1,0,0}
					t:setFillColor(1,0,0)
				elseif i == 1 then
					color = {1,1,0}
					t:setFillColor(1,1,0)
				elseif i == 2 then
					color = {1,0,1}
					t:setFillColor(1,0,1)
				elseif i == 3 then
					color = {0,1,1}
					t:setFillColor(0,1,1)
				elseif i == 4 then
					color = {1,0.5,0}
					t:setFillColor(1,0.5,0)
				elseif i == 5 then
					color = {0,1,0}
					t:setFillColor(0,1,0)
				elseif i == 6 then
					color = {0,0,1}
					t:setFillColor(0,0,1)
				end
				t.trail = SimpleTrail.newTrail({width = 5, widthFinal = 0, numPoints = 10, color = color})
			end
		end

		for i=#particles,1,-1 do
			local p = particles[i]

			if p.lifeTime >= 0 then
				p.x = p.x + p.vx * p.speed
				p.y = p.y + p.vy * p.speed
			end

			if p.lifeTime == 0 then
				transition.to(p, {xScale = 0.001, yScale = 0.001, time = 1000/6})
			end

			p.lifeTime = p.lifeTime - 1

			p.trail:update(p)

			if p.lifeTime <= -10 then
				p:removeSelf()
				p.trail:clear()
				particles[i] = particles[#particles]
				particles[#particles] = nil
			end
		end
	end
end

-------------------------------------------
--EXAMPLE 4 :  multiple trails with offsets
-------------------------------------------
local function initView4(event)
	if currentView then
		currentView:removeSelf()
	end
	local viewDisplayGroup = display.newGroup()
	currentView = viewDisplayGroup

	local ship = display.newImageRect(viewDisplayGroup, "ship.png", 100, 100)
	ship.timer = 0
	local trailShip1 = SimpleTrail.newTrail({tex = "trail_ship.png", numPoints = 20, width = 5, offsetX = 31, offsetY = 40, blendMode = "add"})
	local trailShip2 = SimpleTrail.newTrail({tex = "trail_ship.png", numPoints = 20, width = 5, offsetX = -31, offsetY = 40, blendMode = "add"})
	local trailShip3 = SimpleTrail.newTrail({tex = "trail_rainbow.png", numPoints = 60, width = 10, offsetY = 42})

	--update listener
	viewDisplayGroup.onEnterFrame = function(event)
		--ship movement
		ship.timer = ship.timer + 0.04
		ship.x = display.contentCenterX + math.cos(ship.timer) * 95
		ship.y = display.contentCenterY + math.sin(ship.timer) * 95 - 25
		ship.rotation = math.deg(ship.timer)+180

		trailShip1:update(ship)
		trailShip2:update(ship)
		trailShip3:update(ship)

		ship:toFront()
	end
end

------------------------------
--EXAMPLE 5 :  scrolling trail
------------------------------
local function initView5(event)
	if currentView then
		currentView:removeSelf()
	end
	local viewDisplayGroup = display.newGroup()
	currentView = viewDisplayGroup

	local ball8 = display.newImageRect(viewDisplayGroup, "pool8.png", 40, 40)
	local timer = 4 * math.pi
	local trailBall8 = SimpleTrail.newTrail({tex = "trail_scroll1.png", numPoints = 60, width = 20, widthFinal = 0, scrollSpeed = 0.04})

	local scrollingTextIndex = 3

	viewDisplayGroup.onEnterFrame = function(event)
		--change texture
		timer = timer + 0.05
		if timer >= 4 * math.pi then
			timer = 0
			scrollingTextIndex = scrollingTextIndex + 1
			if scrollingTextIndex > 3 then
				scrollingTextIndex = 1
			end

			if scrollingTextIndex == 1 then
				trailBall8:setTexture("trail_scroll1.png")
				trailBall8.widthFinal = 0
				trailBall8.scrollSpeed = 0.04
			elseif scrollingTextIndex == 2 then
				trailBall8:setTexture("trail_scroll2.png")
				trailBall8.widthFinal = 0
				trailBall8.scrollSpeed = 0.02
			elseif scrollingTextIndex == 3 then
				trailBall8:setTexture("trail_scroll3.png")
				trailBall8.widthFinal = 40
				trailBall8.scrollSpeed = 0.05
			end
		end

		--ball doing 8 movement
		local SIZE_X = 60
		local SIZE_Y = 50
		if timer <= 2 * math.pi then
			ball8.x = SIZE_X - math.cos(timer) * SIZE_X + display.contentCenterX
			ball8.y = math.sin(timer) * SIZE_Y + display.contentCenterY - 25
			--ball8.rotation = -math.deg(timer)+180
		else
			ball8.x = -SIZE_X + math.cos(timer) * SIZE_X + display.contentCenterX
			ball8.y = math.sin(timer) * SIZE_Y + display.contentCenterY - 25
			--ball8.rotation = math.deg(timer)+180
		end

		--draw trail
		trailBall8:update(ball8)
		ball8:toFront()
	end
end

--tab bar to navigate between views
local widget = require "widget"
local tabButtons = {
	{ label="I", defaultFile="btn.png", overFile="btn_down.png", width = 32, height = 32, onPress=initView1, labelYOffset = -3, labelColor = { default={ 0, 0.5, 1 }, over={ 1, 0.5, 0, 1 } }, selected=true },
	{ label="II", defaultFile="btn.png", overFile="btn_down.png", width = 32, height = 32, onPress=initView2, labelYOffset = -3, labelColor = { default={ 0, 0.5, 1 }, over={ 1, 0.5, 0, 1 } } },
	{ label="III", defaultFile="btn.png", overFile="btn_down.png", width = 32, height = 32, onPress=initView3, labelYOffset = -3, labelColor = { default={ 0, 0.5, 1 }, over={ 1, 0.5, 0, 1 } } },
	{ label="IV", defaultFile="btn.png", overFile="btn_down.png", width = 32, height = 32, onPress=initView4, labelYOffset = -3, labelColor = { default={ 0, 0.5, 1 }, over={ 1, 0.5, 0, 1 } } },
	{ label="V", defaultFile="btn.png", overFile="btn_down.png", width = 32, height = 32, onPress=initView5, labelYOffset = -3, labelColor = { default={ 0, 0.5, 1 }, over={ 1, 0.5, 0, 1 } } },
}
local tabBar = widget.newTabBar{
	top = display.screenOriginY + display.actualContentHeight - 50,
	buttons = tabButtons
}

--onTouch listener
local onTouch = function(e)
	if currentView.onTouch then
		currentView.onTouch(e)
	end
end

--onEnterFrame listener
local onEnterFrame = function(e)
	if currentView.onEnterFrame then
		currentView.onEnterFrame(e)
	end
end

local background = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
background:setFillColor(0,0.25,0.25)
background:toBack()

math.randomseed(os.time())
display.setStatusBar(display.HiddenStatusBar)
initView1()
Runtime:addEventListener("touch", onTouch)
Runtime:addEventListener("enterFrame", onEnterFrame)


local onAccelerometerEvent = function(e)
	if e.isShake and system.getInfo("platformName") == "Win" then
		--save screenshot in C:\Users\David\Pictures\Corona Simulator
		local img = display.captureScreen(true)
		img:removeSelf()
		img = nil
	end
end
Runtime:addEventListener("accelerometer", onAccelerometerEvent)