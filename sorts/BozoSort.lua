local BozoSort = {}

local function IsSorted(array)
	if #array == 0 then
		return true
	end

	for index, value in pairs(array) do
		if index == #array then
			return true
		end

		if value > array[index + 1] then
			return false
		end
	end
end

--[[
	Sorts `array` via the bozo sorting algorithm. (in other words, randomly swapping 2 items in the array until it's sorted)
	This sorting algorithm is horribly inefficent and should never be used seriously.
    
	Returns the sorted `array` for convenience.
]]
function BozoSort.sort(array)
	while not IsSorted(array) do
		local Pos1 = math.random(1, #array)
		local Pos2 = math.random(1, #array)

		array[Pos1], array[Pos2] = array[Pos2], array[Pos1]
	end

	return array
end

return BozoSort
