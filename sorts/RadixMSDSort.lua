local RadixMSDSort = {}

local function DigitAt(num, pos, base)
	if num < 0 then
		-- This ensures this returns negative numbers when a negative `num` is specified
		return math.ceil(num / math.pow(base, pos - 1)) % -base
	else
		return math.floor(num / math.pow(base, pos - 1)) % base
	end
end

local function SortDigitPositive(array, radix, position, left, right)
	if right <= left or position <= 0 then
		return
	end

	local Buckets = {}
	for i = 1, radix do
		table.insert(Buckets, {})
	end

	for i = left, right do
		local Index = DigitAt(array[i], position, radix) + 1
		table.insert(Buckets[Index], array[i])
	end

	local Total = 0
	for _, v in pairs(Buckets) do
		Total = Total + #v
	end

	local K = 1
	for i = #Buckets, 1, -1 do
		for j = #Buckets[i], 1, -1 do
			array[Total + left - K] = Buckets[i][j]
			K = K + 1
		end
	end

	local NextBucketPosition = 0
	for _, v in pairs(Buckets) do
		SortDigitPositive(array, radix, position - 1, NextBucketPosition + left, NextBucketPosition + left + #v - 1)
		NextBucketPosition = NextBucketPosition + #v
	end
end

--[[
	Sorts `array` via the radix sorting algorithm (starts from the most significant digit)
	with the base `radix`. (default 10)

	Note that this implementation of the radix MSD sort doesn't support sorting negative numbers;
	trying to do so will result in an error.
    
	Returns the sorted `array` for convenience.
]]
function RadixMSDSort.sortPositive(array, radix)
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
	SortDigitPositive(array, radix, LargestExponent, 1, #array)

	return array
end

local function SortDigit(array, radix, position, left, right)
	if right <= left or position <= 0 then
		return
	end

	local Buckets = {}
	for i = 1, (radix * 2) - 1 do
		table.insert(Buckets, {})
	end

	for i = left, right do
		local Index = DigitAt(array[i], position, radix) + radix
		table.insert(Buckets[Index], array[i])
	end

	local Total = 0
	for _, v in pairs(Buckets) do
		Total = Total + #v
	end

	local K = 1
	for i = #Buckets, 1, -1 do
		for j = #Buckets[i], 1, -1 do
			array[Total + left - K] = Buckets[i][j]
			K = K + 1
		end
	end

	local NextBucketPosition = 0
	for _, v in pairs(Buckets) do
		SortDigit(array, radix, position - 1, NextBucketPosition + left, NextBucketPosition + left + #v - 1)
		NextBucketPosition = NextBucketPosition + #v
	end
end

--[[
	Sorts `array` via the radix sorting algorithm (starts from the most significant digit)
	with the base `radix`. (default 10)
    
	Returns the sorted `array` for convenience.
]]
function RadixMSDSort.sort(array, radix)
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
	SortDigit(array, radix, LargestExponent, 1, #array)

	return array
end

return RadixMSDSort
