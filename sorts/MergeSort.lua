local MergeSort = {}

local function Populate(array, value, count)
	for i = 1, count do
		table.insert(array, value)
	end

	return array
end

local function Merge(array, left, mid, right)
	local LeftArray = Populate({}, 0, mid - left + 1)
	local RightArray = Populate({}, 0, right - mid)

	for i = 1, #LeftArray do
		LeftArray[i] = array[left + i - 1]
	end

	for j = 1, #RightArray do
		RightArray[j] = array[mid + j]
	end

	local LeftIndex = 1
	local RightIndex = 1
	local MergedIndex = left

	while LeftIndex <= #LeftArray and RightIndex <= #RightArray do
		if LeftArray[LeftIndex] < RightArray[RightIndex] then
			array[MergedIndex] = LeftArray[LeftIndex]

			LeftIndex = LeftIndex + 1
		else
			array[MergedIndex] = RightArray[RightIndex]

			RightIndex = RightIndex + 1
		end

		MergedIndex = MergedIndex + 1
	end

	while LeftIndex <= #LeftArray do
		array[MergedIndex] = LeftArray[LeftIndex]

		LeftIndex = LeftIndex + 1
		MergedIndex = MergedIndex + 1
	end

	while RightIndex <= #RightArray do
		array[MergedIndex] = RightArray[RightIndex]

		RightIndex = RightIndex + 1
		MergedIndex = MergedIndex + 1
	end
end

local function Sort(array, left, right)
	if left < right then
		local Mid = math.floor(left + (right - left) / 2)

		Sort(array, left, Mid)
		Sort(array, Mid + 1, right)

		Merge(array, left, Mid, right)
	end

	return array
end

--[[
	Sorts `array` via the merge sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function MergeSort.sort(array)
	return Sort(array, 1, #array)
end

return MergeSort
