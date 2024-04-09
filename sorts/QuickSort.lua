local QuickSort = {}

local function LomutoPartition(array, left, right)
	local Pivot = array[right]
	local I = left

	for j = left, right do
		if Pivot > array[j] then
			array[I], array[j] = array[j], array[I]

			I = I + 1
		end
	end

	array[I], array[right] = array[right], array[I]
	return I
end

--[[
	Sorts `array` via the quick sorting algorithm that uses Lomuto's partition scheme.

	Returns the sorted `array` for convenience.
]]
function QuickSort.sortLomuto(array, left, right)
	if not left then
		left = 1
	end

	if not right then
		right = #array
	end

	if left >= 1 and right >= 1 and left < right then
		local Pivot = LomutoPartition(array, left, right)

		QuickSort.sortLomuto(array, left, Pivot - 1)
		QuickSort.sortLomuto(array, Pivot + 1, right)
	end

	return array
end

local function HoarePartition(array, left, right)
	local PivotIndex = math.floor((left + right) / 2)
	local Pivot = array[PivotIndex]

	local Left = left - 1
	local Right = right + 1

	while true do
		repeat
			Left = Left + 1
		until array[Left] >= Pivot

		repeat
			Right = Right - 1
		until array[Right] <= Pivot

		if Left >= Right then
			return Right
		end

		array[Left], array[Right] = array[Right], array[Left]
	end
end

--[[
	Sorts `array` via the quick sorting algorithm that uses Hoare's partition scheme.

	Returns the sorted `array` for convenience.
]]
function QuickSort.sortHoare(array, left, right)
	if not left then
		left = 1
	end

	if not right then
		right = #array
	end

	if left >= 1 and right >= 1 and left < right then
		local Pivot = HoarePartition(array, left, right)

		QuickSort.sortHoare(array, left, Pivot)
		QuickSort.sortHoare(array, Pivot + 1, right)
	end

	return array
end

local function HoarePartitionMedianOf3(array, left, right)
	local PivotIndex = math.floor((left + right) / 2)
	local Pivot = array[PivotIndex]

	if array[left] > Pivot then
		array[left], array[PivotIndex] = array[PivotIndex], array[left]
	end

	if array[right] > array[left] then
		array[right], array[left] = array[left], array[right]
	end

	if Pivot > array[right] then
		array[PivotIndex], array[right] = array[right], array[PivotIndex]
	end

	Pivot = array[right]

	local Left = left - 1
	local Right = right + 1
	while true do
		repeat
			Left = Left + 1
		until array[Left] >= Pivot

		repeat
			Right = Right - 1
		until array[Right] <= Pivot

		if Left >= Right then
			return Right
		end

		array[Left], array[Right] = array[Right], array[Left]
	end
end

--[[
	Sorts `array` via the quick sorting algorithm. 
	This uses Hoare's partition scheme with "median-of-3" (choose the median of the first, middle or last) \
	to choose which pivot for partitioning.

	Returns the sorted `array` for convenience.
]]
function QuickSort.sortHoareMedianOf3(array, left, right)
	if not left then
		left = 1
	end

	if not right then
		right = #array
	end

	if left >= 1 and right >= 1 and left < right then
		local Pivot = HoarePartitionMedianOf3(array, left, right)

		QuickSort.sortHoare(array, left, Pivot)
		QuickSort.sortHoare(array, Pivot + 1, right)
	end

	return array
end

--[[
	Sorts `array` via the quick sorting algorithm.
	This uses Hoare's partition scheme with "median-of-3" to choose the pivot.

	Returns the sorted `array` for convenience.
]]
function QuickSort.sort(array)
	return QuickSort.sortHoareMedianOf3(array, 1, #array)
end

return QuickSort
