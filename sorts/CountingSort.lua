local CountingSort = {}

local function Populate(array, value, count)
	for i = 1, count do
		table.insert(array, value)
	end

	return array
end

--[[
	Sorts `array` via the counting sorting algorithm. 
    This is a implementation that doesn't support sorting negative numbers and zero.
    As such, trying to sort unsupported numbers will result in an error.
    
	Returns the sorted `array` for convenience.
]]
function CountingSort.sortPositive(array)
	if #array == 0 then
		return array
	end

	local Max = array[1]
	for i, v in pairs(array) do
		if v > Max then
			Max = v
		end

		if v <= 0 then
			error(
				string.format(
					"CountingSort.sortPositive doesn't support sorting the number %i. This method only supports integers >= 1.",
					v
				)
			)
		end
	end

	local Count = Populate({}, 0, Max)
	for i, v in pairs(array) do
		Count[v] = Count[v] + 1
	end

	for i = 2, #Count do
		Count[i] = Count[i] + Count[i - 1]
	end

	local Out = Populate({}, 0, #array)
	for _, v in pairs(array) do
		Out[Count[v]] = v
		Count[v] = Count[v] - 1
	end

	for i, v in pairs(Out) do
		array[i] = Out[i]
	end

	return array
end

--[[
	Sorts `array` via the counting sorting algorithm.
    
	Returns the sorted `array` for convenience.
]]
function CountingSort.sort(array)
	if #array == 0 then
		return array
	end

	local Min, Max = array[1], array[1]
	for i, v in pairs(array) do
		if v > Max then
			Max = v
		elseif v < Min then
			Min = v
		end
	end

	local Range = Max - (Min - 1)
	local Offset = -(Min - 1)
	local Count = Populate({}, 0, Range)

	for i, v in pairs(array) do
		Count[v + Offset] = Count[v + Offset] + 1
	end

	for i = 2, #Count do
		Count[i] = Count[i] + Count[i - 1]
	end

	local Out = Populate({}, 0, #array)
	for _, v in pairs(array) do
		Out[Count[v + Offset]] = v
		Count[v + Offset] = Count[v + Offset] - 1
	end

	for i, _ in pairs(Out) do
		array[i] = Out[i]
	end

	return array
end

return CountingSort
