local SelectionSort = {}

--[[
	Sorts `array` via the selection sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function SelectionSort.sort(array)
	for i = 1, #array do
		local SelectedIndex = i
		for j = i + 1, #array do
			if array[j] <= array[SelectedIndex] then
				SelectedIndex = j
			end
		end

		array[i], array[SelectedIndex] = array[SelectedIndex], array[i]
	end

	return array
end

return SelectionSort
