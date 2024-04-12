local BitonicSort = {}

local function BiggestPowerOfTwoLessThan(n)
	local Exponent = 0
	while true do
		local CurrentPowerOfTwo = math.ldexp(1, Exponent)
		if CurrentPowerOfTwo >= n then
			-- Shrink the exceeded `CurrentPowerOfTwo` to ensure we actually return a number that's less than `n`
			return CurrentPowerOfTwo / 2
		end

		Exponent = Exponent + 1
	end
end

local function MergeSection(array, bound_start, size, direction_ascending)
	if size == 1 then
		return array
	end

	local Mid = BiggestPowerOfTwoLessThan(size)

	for i = bound_start, bound_start + size - Mid - 1 do
		if direction_ascending == (array[i] > array[i + Mid]) then
			array[i], array[i + Mid] = array[i + Mid], array[i]
		end
	end

	MergeSection(array, bound_start, Mid, direction_ascending)
	MergeSection(array, bound_start + Mid, size - Mid, direction_ascending)

	return array
end

local function SortSection(array, bound_start, size, direction_ascending)
	if size == 1 then
		return array
	end

	local Mid = math.floor(size / 2)

	SortSection(array, bound_start, Mid, not direction_ascending)
	SortSection(array, bound_start + Mid, size - Mid, direction_ascending)
	MergeSection(array, bound_start, size, direction_ascending)

	return array
end

--[[
	Sorts `array` via the bitonic sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function BitonicSort.sort(array)
	if #array == 0 then
		return array
	end

	return SortSection(array, 1, #array, true)
end

return BitonicSort
