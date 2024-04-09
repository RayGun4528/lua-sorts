local RadixLSDSort = {}

local function DigitAt(num, pos, base)
	if num < 0 then
		-- This ensures this returns negative numbers when a negative `num` is specified
		return math.ceil(num / math.pow(base, pos - 1)) % -base
	else
		return math.floor(num / math.pow(base, pos - 1)) % base
	end
end

local function Populate(array, value, count)
	for i = 1, count do
		table.insert(array, value)
	end

	return array
end

local function SortDigitPositive(array, radix, position)
	-- Extend the count to also support sorting negative numbers
	local Count = Populate({}, 0, radix)

	for i, v in pairs(array) do
		local Index = DigitAt(v, position, radix) + 1
		Count[Index] = Count[Index] + 1
	end

	for i = 2, #Count do
		Count[i] = Count[i] + Count[i - 1]
	end

	local Out = Populate({}, 0, #array)
	for i = #array, 1, -1 do
		local Index = DigitAt(array[i], position, radix) + 1

		Out[Count[Index]] = array[i]
		Count[Index] = Count[Index] - 1
	end

	for i, v in pairs(Out) do
		array[i] = v
	end
end

--[[
	Sorts `array` via the radix sorting algorithm (starts from the least significant digit)
	with the base `radix`. (default 10)
	
	Note that this implementation of the radix LSD sort doesn't support sorting negative numbers;
	trying to do so will result in an error.
    
	Returns the sorted `array` for convenience.
]]
function RadixLSDSort.sortPositive(array, radix)
	if #array == 0 then
		return array
	end

	if not radix then
		radix = 10
	end

	local Max = array[1]
	for i, v in pairs(array) do
		if v > Max then
			Max = v
		end

		if v < 0 then
			error(
				string.format(
					"CountingSort.sortPositive doesn't support sorting the number %i. This method only supports integers >= 1.",
					v
				)
			)
		end
	end

	local LargestExponent = math.ceil(math.log(Max + 1) / math.log(radix))
	for position = 1, LargestExponent do
		SortDigitPositive(array, radix, position)
	end

	return array
end

local function SortDigit(array, radix, position)
	-- Extend the count to also support sorting negative numbers
	local Count = Populate({}, 0, radix * 2 - 1)

	for i, v in pairs(array) do
		local Index = DigitAt(v, position, radix) + radix
		Count[Index] = Count[Index] + 1
	end

	for i = 2, #Count do
		Count[i] = Count[i] + Count[i - 1]
	end

	local Out = Populate({}, 0, #array)
	for i = #array, 1, -1 do
		local Value = array[i]
		local Index = DigitAt(Value, position, radix) + radix

		Out[Count[Index]] = Value
		Count[Index] = Count[Index] - 1
	end

	for i, v in pairs(Out) do
		array[i] = v
	end
end

--[[
	Sorts `array` via the radix sorting algorithm (starts from the least significant digit.)
	with the base `radix`. (default 10.)
    
	Returns the sorted `array` for convenience.
]]
function RadixLSDSort.sort(array, radix)
	if #array == 0 then
		return array
	end

	if not radix then
		radix = 10
	end

	local Min, Max = array[1], array[1]
	for i, v in pairs(array) do
		if v > Max then
			Max = v
		elseif v < Min then
			Min = v
		end
	end

	local LargestExponent = math.ceil(math.log(math.max(math.abs(Max), math.abs(Min)) + 1) / math.log(radix))
	for position = 1, LargestExponent do
		SortDigit(array, radix, position)
	end

	return array
end

return RadixLSDSort
