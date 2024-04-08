local BucketSort = {}

local function InsertionSort(array)
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

	return array
end

local function IsFloat(n)
	return math.ceil(n) ~= n
end

--[[
	Sorts `array` via the bucket sorting algorithm, with the amount of `buckets` (default 10).

	Returns the sorted `array` for convenience.
]]
function BucketSort.sort(array, buckets)
	if #array <= 1 then
		return array
	end

	if not buckets then
		buckets = 10
	elseif buckets <= 0 or IsFloat(buckets) or type(buckets) ~= "number" then
		error(string.format("Cannot sort with %s buckets. You must provide a positive integer.", tostring(buckets)))
	end

	local Buckets = {}

	for i = 1, buckets do
		table.insert(Buckets, {})
	end

	-- Determine maximum and minimum
	local HighestValue = array[1]
	local LowestValue = array[1]
	for i, v in pairs(array) do
		if v > HighestValue then
			HighestValue = v
		elseif v < LowestValue then
			LowestValue = v
		end
	end

	local RangeOfValues = HighestValue - LowestValue
	if LowestValue == 0 then
		RangeOfValues = RangeOfValues + 1
	end
	if HighestValue == 0 then
		RangeOfValues = RangeOfValues + 1
		-- Ensure no division-by-zero happens at the function below
		HighestValue = 1
	end

	-- Position the numbers accordingly
	for i, v in pairs(array) do
		local ValuePosition = v - LowestValue
		local Percentage = ValuePosition / RangeOfValues
		table.insert(Buckets[math.floor((buckets * Percentage) / math.abs(HighestValue)) + 1], v)
	end

	-- Update the values in the starting array
	local Left = 1
	for idx, bucket in pairs(Buckets) do
		for idx1, val in pairs(bucket) do
			array[Left + (idx1 - 1)] = val
		end
		Left = Left + #bucket
	end

	return InsertionSort(array)
end

return BucketSort
