local SlowSort = {}

local function Sort(array, i, j)
	if i >= j then
		return array
	end

	local Mid = math.floor((i + j) / 2)

	Sort(array, i, Mid)
	Sort(array, Mid + 1, j)

	if array[j] <= array[Mid] then
		array[j], array[Mid] = array[Mid], array[j]
	end

	return Sort(array, i, j - 1)
end

--[[
	Sorts `array` via the slow sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function SlowSort.sort(array)
	return Sort(array, 1, #array)
end

return SlowSort
