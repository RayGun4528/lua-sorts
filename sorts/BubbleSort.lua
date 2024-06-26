local BubbleSort = {}

--[[
	Sorts `array` via the bubble sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function BubbleSort.sort(array)
	local Length = #array

	repeat
		local IsSwapped = false

		for i = 2, Length do
			if array[i - 1] > array[i] then
				array[i - 1], array[i] = array[i], array[i - 1]
				IsSwapped = true
			end
		end

		Length = Length - 1
	until not IsSwapped

	return array
end

return BubbleSort
