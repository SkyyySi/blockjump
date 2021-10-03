package.path = package.path .. ";lib/?.lua;lib/?/init.lua"

function love.load()
	local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]

	--[[ 0: Keyboard,
	     1: Joystick/-pad ]]
	inputtype = 0
	if joystick then
		inputtype = 1
	end

	base = require "base"
	movement = require "movement"

	windowwidth, windowheight = love.graphics.getDimensions()
	w, h = 50, 50
	x, y = (windowwidth / 2) - (w / 2), (windowheight / 2) - (h / 2)
end

function love.draw()
	love.graphics.rectangle("fill", x, y, w, h)
end

function love.update(dt)
	local directions = movement.process(movement.get(dt * 500, inputtype), true)

	if directions then
		x = x + directions.x
		y = y + directions.y
	end

	if x < 0 then x = 0 end
	if x > windowwidth - 50 then x = windowwidth - 50 end
	if y < 0 then y = 0 end
	if y > windowheight - 50 then y = windowheight - 50 end
end
