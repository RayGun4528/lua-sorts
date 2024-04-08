local PigeonholeSort = {}

local function Populate(array, value, count)
	for i = 1, count do
		table.insert(array, value)
	end

	return array
end

--[[
	Sorts `array` via the pigeonhole sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function PigeonholeSort.sort(array)
	if #array <= 1 then
		return array
	end

	local Min, Max = array[1], array[1]

	for _, v in pairs(array) do
		if v < Min then
			Min = v
		elseif v > Max then
			Max = v
		end
	end

	local Range = Max - Min + 1
	local Pigeonholes = Populate({}, 0, Range)
	for idx, val in pairs(array) do
		local CurrentIndex = val - Min + 1
		Pigeonholes[CurrentIndex] = Pigeonholes[CurrentIndex] + 1
	end

	local Idx = 1
	for count = 1, Range do
		while Pigeonholes[count] >= 1 do
			Pigeonholes[count] = Pigeonholes[count] - 1
			array[Idx] = count + (Min - 1)

			Idx = Idx + 1
		end
	end

	return array
end

return PigeonholeSort
