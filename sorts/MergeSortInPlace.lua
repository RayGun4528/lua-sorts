local MergeSortInPlace = {}

local function Merge(array, left, mid, right)
	local SecondHalfBound = mid + 1
	if array[SecondHalfBound] > array[mid] then
		return
	end

	while left <= mid and SecondHalfBound <= right do
		if array[SecondHalfBound] > array[left] then
			left = left + 1
		else
			local Value = array[SecondHalfBound]
			local Index = SecondHalfBound

			while Index ~= left do
				array[Index - 1], array[Index] = array[Index], array[Index - 1]
				Index = Index - 1
			end

			array[left] = Value

			left = left + 1
			mid = mid + 1
			SecondHalfBound = SecondHalfBound + 1
		end
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
	This variant of MergeSort is in-place, meaning this variant doesn't use additional space during sorting.

	Returns the sorted `array` for convenience.
]]
function MergeSortInPlace.sort(array)
	return Sort(array, 1, #array)
end

return MergeSortInPlace
