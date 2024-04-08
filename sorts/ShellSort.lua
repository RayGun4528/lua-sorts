local ShellSort = {}

function ShellSort.sort(array)
	local Length = #array
	local Gap = math.floor(Length / 2)

	while Gap > 0 do
		for i = Gap + 1, Length do
			local Temp = array[i]

			local J = i
			while J > Gap and array[J - Gap] > Temp do
				array[J], array[J - Gap] = array[J - Gap], array[J]

				J = J - Gap
			end

			array[J] = Temp
		end

		Gap = math.floor(Gap / 2)
	end

	return array
end

return ShellSort
