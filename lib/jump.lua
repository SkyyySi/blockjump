local ease     = require "ease"
--local base     = require "base"
--local movement = require "movement"

local jump = {
	isjumping = false,
}

function jump:set_status(pstatus)
	self.isjumping = pstatus
end

function jump.process(pspeed, pmultiplier)
	jump:set_status(true)
	print(jump.isjumping)

	xprejump = x
	easedpos = 0
	while easedpos < 0.5 do
		local framedelta = love.timer.getDelta() / pspeed
		if framedelta > 1 then framedelta = 1 end
		local newtarget  = framedelta
		easedpos = ease.easeOutQuad(easedpos + newtarget)
		y = y - (easedpos * pmultiplier)
		print(y)
	end

	jump:set_status(false)
end

function jump.jump(pspeed, pmultiplier)
	pspeed      = pspeed      or 1 -- speed in seconds
	pmultiplier = pmultiplier or 1 -- jump height

	if jump.isjumping == false then
		jump:set_status(true)
		print("Called")
		jump.process(pspeed, pmultiplier)
	end
end

return jump
