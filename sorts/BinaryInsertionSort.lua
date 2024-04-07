local BinaryInsertionSort = {}

--[[
	Given a sorted `array` and `item`, returns a numerical index such that when the `item`
	is inserted into the sorted `array` at that position, the `array` remains sorted.

	`upper_bound` is an optional parameter that specifies the highest index the `item` can be
	inserted. If `upper_bound` is not provided, the array's size is used instead.
]]
function BinaryInsertionSort.bisect(array, item, upper_bound)
	local Left = 1
	local Right = upper_bound or #array

	while Left < Right do
		local Mid = math.floor((Left + Right) / 2)

		if array[Mid] <= item then
			Left = Mid + 1
		else
			Right = Mid
		end
	end

	return Left
end

--[[
	Sorts `array` via the binary insertion sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function BinaryInsertionSort.sort(array)
	for index, value in ipairs(array) do
		local CorrectIndex = BinaryInsertionSort.bisect(array, value, index)

		local ValueIndex = index
		while ValueIndex > CorrectIndex do
			array[ValueIndex] = array[ValueIndex - 1]
			ValueIndex = ValueIndex - 1
		end

		array[CorrectIndex] = value
	end

	return array
end

return BinaryInsertionSort
