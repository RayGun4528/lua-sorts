local CocktailShakerSort = {}

function CocktailShakerSort.sort(array)
	repeat
		local IsSwapped = false
		for i = 1, #array - 1 do
			if array[i] > array[i + 1] then
				array[i], array[i + 1] = array[i + 1], array[i]

				IsSwapped = true
			end
		end

		if not IsSwapped then
			break
		end

		for i = #array - 1, 1, -1 do
			if array[i] > array[i + 1] then
				array[i], array[i + 1] = array[i + 1], array[i]

				IsSwapped = true
			end
		end
	until not IsSwapped

	return array
end

return CocktailShakerSort
