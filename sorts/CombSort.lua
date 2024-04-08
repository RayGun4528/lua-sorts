local CombSort = {}

--[[
	Sorts `array` via the comb sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function CombSort.sort(array)
	local ShrinkFactor = 1.3
	local Gap = #array
	local IsSorted = false

	while not IsSorted do
		Gap = Gap / ShrinkFactor
		IsSorted = false

		local RoundedGap = math.floor(Gap)
		if RoundedGap <= 1 then
			RoundedGap = 1
			IsSorted = true
		end

		for index_a = 1, #array - RoundedGap do
			local IndexB = index_a + RoundedGap
			if array[index_a] > array[IndexB] then
				array[index_a], array[IndexB] = array[IndexB], array[index_a]

				IsSorted = false
			end
		end
	end

	return array
end

return CombSort
