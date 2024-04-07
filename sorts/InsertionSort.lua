local InsertionSort = {}

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

	return
end

return InsertionSort
