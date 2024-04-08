local PancakeSort = {}

local function Flip(array, right)
	local Left = 1
	while Left < right do
		array[Left], array[right] = array[right], array[Left]

		Left = Left + 1
		right = right - 1
	end
end

--[[
	Sorts `array` via the pancake sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function PancakeSort.sort(array)
	for i = #array, 2, -1 do
		local MaxIndex = 1
		for j = 1, i do
			if array[j] > array[MaxIndex] then
				MaxIndex = j
			end
		end

		if MaxIndex ~= i then
			Flip(array, MaxIndex)
			Flip(array, i)
		end
	end

	return array
end

return PancakeSort
