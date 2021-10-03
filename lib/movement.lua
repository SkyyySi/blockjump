local base = require "base"

local movement = {
	current = {
		up    = 0,
		down  = 0,
		left  = 0,
		right = 0,
	}
}

--[[ Update the current status for a given direction ]]
function movement:set(pdirection, pstate)
	self.current[pdirection] = pstate
end

--[[ Returns true if any key in the `keys` table is pushed ]]
function movement.multikey(pkeys) --> boolean
	for _,v in pairs(pkeys) do
		if love.keyboard.isDown(v) then
			return true
		end
	end

	return false
end

movement.read = {
	keyboard = function(factor)
		movement:set("up", 0)
		movement:set("down", 0)
		movement:set("left", 0)
		movement:set("right", 0)

		if movement.multikey({"up", "w"}) then
			movement:set("up", 1 * factor)
		end

		if movement.multikey({"down", "s"}) then
			movement:set("down", 1 * factor)
		end

		if movement.multikey({"left", "a"}) then
			movement:set("left", 1 * factor)
		end

		if movement.multikey({"right", "d"}) then
			movement:set("right", 1 * factor)
		end
	end,

	joystick = function(factor)
		movement:set("up", 0)
		movement:set("down", 0)
		movement:set("left", 0)
		movement:set("right", 0)

		if joystick:isGamepadDown("dpup") then
			movement:set("up", 1 * factor)
		end

		if joystick:isGamepadDown("dpdown") then
			movement:set("down", 1 * factor)
		end

		if joystick:isGamepadDown("dpleft") then
			movement:set("left", 1 * factor)
		end

		if joystick:isGamepadDown("dpright") then
			movement:set("right", 1 * factor)
		end
	end,
}

function movement.get(factor, pinputtype) --> table
	if not factor then factor = 1 end

	--[[ Set the `movement.direction_table` for the currently pushed
	direction(s) to a number representing its current state
	(booleans are not used in order to allow for analog movement) ]]
	if pinputtype == 0 then
		movement.read.keyboard(factor)
	elseif pinputtype == 1 then
		movement.read.joystick(factor)
	end

	return movement.current
end

function movement.process(pdirections, pstayonscreen)
	-- Do nothing if `directions` is empty or if it doesn't contain anything.
	if (not pdirections) or (pdirections == {}) then return end

	if pstayonscreen == nil then pstayonscreen = false end

	local movement_processed = {
		x = 0,
		y = 0
	}

	if (pdirections.right > 0) and (pdirections.left <= 0) then
		movement_processed.x = pdirections.right
	end

	if (pdirections.left > 0) and (pdirections.right <= 0) then
		movement_processed.x = -pdirections.left
	end

	if (pdirections.down > 0) and (pdirections.up <= 0) then
		movement_processed.y = pdirections.down
	end

	if (pdirections.up > 0) and (pdirections.down <= 0) then
		movement_processed.y = -pdirections.up
	end

	return movement_processed
end

return movement
