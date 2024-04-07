local CocktailShakerSort = {}

function CocktailShakerSort.sort(array)
	repeat
		local Swapped = false
		for i = 1, #array - 1 do
			if array[i] > array[i + 1] then
				array[i], array[i + 1] = array[i + 1], array[i]

				Swapped = true
			end
		end

		if not Swapped then
			break
		end

		for i = #array - 1, 1, -1 do
			if array[i] > array[i + 1] then
				array[i], array[i + 1] = array[i + 1], array[i]

				Swapped = true
			end
		end
	until not Swapped

	return array
end

return CocktailShakerSort
