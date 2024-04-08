local InsertionSort = {}

--[[
	Sorts `array` via the insertion sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function InsertionSort.sort(array)
	for i = 1, #array - 1 do
		local J = i
		while array[J] > array[J + 1] do
			array[J], array[J + 1] = array[J + 1], array[J]

			J = J - 1
			if J == 0 then
				break
			end
		end
	end

	return array
end

return InsertionSort
