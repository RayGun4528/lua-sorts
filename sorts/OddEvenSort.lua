local OddEvenSort = {}

--[[
	Sorts `array` via the odd even sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function OddEvenSort.sort(array)
	local Sorted = false

	while not Sorted do
		Sorted = true

		for i = 1, #array - 1, 2 do
			if array[i] > array[i + 1] then
				array[i], array[i + 1] = array[i + 1], array[i]

				Sorted = false
			end
		end

		for i = 2, #array - 1, 2 do
			if array[i] > array[i + 1] then
				array[i], array[i + 1] = array[i + 1], array[i]

				Sorted = false
			end
		end
	end

	return array
end

return OddEvenSort
