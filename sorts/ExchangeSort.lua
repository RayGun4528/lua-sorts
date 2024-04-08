local ExchangeSort = {}

--[[
	Sorts `array` via the comb sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function ExchangeSort.sort(array)
	local Length = #array
	for i = 1, Length do
		for j = i + 1, Length do
			if array[i] > array[j] then
				array[i], array[j] = array[j], array[i]
			end
		end
	end

	return array
end

return ExchangeSort
