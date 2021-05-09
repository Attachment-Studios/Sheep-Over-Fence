
function love.load()
	if love.system.getOS() == "Windows" then
		love.window.setMode(640, 360, { resizable = true })
	end

	music = love.audio.newSource('Music.mp3', 'stream')

	music:setLooping(true)
	music:play()

	tutorialText = "Try till you jump!"

	ltt = function() return love.timer.getTime() end
	
	tutorial = ltt()

	lg = love.graphics
	sprites = { lg.newImage('Run 1.png'), lg.newImage('Run 2.png') }
	spriteCount = 1
	spriteTick = ltt()
	spriteTimer = 0.1

	w = lg.getWidth()
	h = lg.getHeight()

	ground = h*2/3

	speed = 200
	
	x = 100
	y = ground

	gravity = 1
	gmult = 1

	isJumping = false
end

function love.update(dt)
	if ltt() - spriteTick >= spriteTimer then
		spriteTick = ltt()
		spriteCount = spriteCount + 1
		if spriteCount > 2 then
			spriteCount = 1
		end
	end

	w = lg.getWidth()
	h = lg.getHeight()

	ground = h*2/3

	gravity = gravity + 20 * dt
	y = y + (gravity * gmult)
	if y > ground then
		gravity = 0
		y = ground
		isJumping = false
	end

	x = x + speed * dt
	if x > w + 100 then
		x = -100
	end

	if ltt() - tutorial >= 10 then
		tutorial = 0
	end

	if x + (565*(0.0003*(math.max(w, h)-math.min(w, h)))) > w/2-(0.05*(math.max(w, h)-math.min(w, h))) and x < (w/2-(0.05*(math.max(w, h)-math.min(w, h)))) + (0.05*(math.max(w, h)-math.min(w, h))) then
		if y <= ground and y >= ground - (0.2*(math.max(w, h)-math.min(w, h))) then
			x = -100
		end
	end
end

function love.draw()
	lg.setBackgroundColor(0.2, 0.63, 1, 1)

	lg.setColor(0, 0, 0, tutorial)
	lg.print(tutorialText, 10, 10)

	lg.setColor(1, 1, 1, 1)
	lg.draw(sprites[spriteCount], x, y-(473*(0.0003*(math.max(w, h)-math.min(w, h)))), 0, 0.0003*(math.max(w, h)-math.min(w, h)), 0.0003*(math.max(w, h)-math.min(w, h)))

	lg.setColor(0.8, 0.3, 0.1, 1)
	lg.rectangle("fill", w/2-(0.05*(math.max(w, h)-math.min(w, h))), ground-(0.2*(math.max(w, h)-math.min(w, h))), 0.05*(math.max(w, h)-math.min(w, h)), 0.2*(math.max(w, h)-math.min(w, h)))

	lg.setColor(0.4, 1, 0.63)
	lg.rectangle("fill", -100, ground, w+100, h)
end

function love.keypressed(k)
	if isJumping == false then
		gravity = -10
		isJumping = true
	end
end

function love.mousepressed(k)
	if isJumping == false then
		gravity = -10
		isJumping = true
	end
end

function love.touchpressed(k)
	if isJumping == false then
		gravity = -10
		isJumping = true
	end
end
