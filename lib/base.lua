local base = {
	--[[ Convert a table into a human-readable string. Mainly for debuggin. ]]
	untable = function(ptable)
		if not ptable or ptable == {} then return end

		local out = ""
		for i,v in pairs(ptable) do
			out = out .. "index = "..tostring(i)..": "..type(i)..", value = "..tostring(v)..": "..type(v) .. "\n"
		end

		return out
	end,

	--[[ Compare 2 tables based on their contents rathen than if they are exactly identical.
	     returns `true` if they match and `false` otherwise. ]]
	tablecompare = function(ptableone, ptabletwo)
		for i,v in pairs(ptableone) do
			if v ~= ptabletwo[i] then
				return false
			end
		end

		-- Unfortionatly for performance, this has to be done once for each table.
		-- Because otherwise, `{ a = "A", b = "B" }` and `{ a = "A", b = "B", c = "C" }`
		-- would return `true`.
		for i,v in pairs(ptabletwo) do
			if v ~= ptableone[i] then
				return false
			end
		end

		return true
	end,

	--[[ Constrain a number to be inbetween a minimum and a maximum. ]]
	constrain = function(pnumber, pmin, pmax)
		if pnumber < pmin then return pmin end
		if pnumber > pmax then return pmax end
		return pnumber
	end
}

return base
