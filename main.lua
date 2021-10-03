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
	x, y = 10, 10
end

function love.draw()
	love.graphics.rectangle("fill", x, y, 50, 50)
end

function love.update(dt)
	local directions = movement.process(movement.get(dt * 500, inputtype), true)

	if directions then
		x = x + directions.x
		y = y + directions.y
	end

	local w, h = love.graphics.getDimensions()
	if x < 0 then x = 0 end
	if x > w - 50 then x = w - 50 end
	if y < 0 then y = 0 end
	if y > h - 50 then y = h - 50 end
end
