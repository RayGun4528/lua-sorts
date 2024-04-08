local StoogeSort = {}

local function Sort(array, i, j)
	if array[i] > array[j] then
		array[i], array[j] = array[j], array[i]
	end

	if (j - i + 1) > 2 then
		local T = math.floor((j - i + 1) / 3)
		Sort(array, i, j - T)
		Sort(array, i + T, j)
		Sort(array, i, j - T)
	end

	return array
end

--[[
	Sorts `array` via the stooge sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function StoogeSort.sort(array)
	if #array == 0 then
		return array
	end

	return Sort(array, 1, #array)
end

return StoogeSort
