local BogoSort = {}

--[[
	Sorts `array` via the bogo sorting algorithm. (in other words, shuffling the array until it's sorted)
	This sorting algorithm is horribly inefficent and should never be used seriously.
    
	Returns the sorted `array` for convenience.
]]
function BogoSort.sort(array)
	while true do
		local Sorted = true

		for idx, v in pairs(array) do
			if idx == #array then
				break
			end

			if v > array[idx + 1] then
				Sorted = false
				break
			end
		end

		if Sorted then
			break
		end

		local Shuffle = {}
		for _, item in pairs(array) do
			local Position = math.random(1, #Shuffle + 1)
			table.insert(Shuffle, Position, item)
		end

		for idx, item in pairs(Shuffle) do
			array[idx] = item
		end
	end

	return array
end

return BogoSort
