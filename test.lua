local function StringifyArray(array)
	local Result = "{"

	for idx, val in ipairs(array) do
		Result = Result .. tostring(val)

		-- If the next index isn't empty then add a separator
		if array[idx + 1] ~= nil then
			Result = Result .. ", "
		end
	end

	Result = Result .. "}"
	return Result
end

local function GetSortNames()
	-- Only works on Windows, for Linux you'd do this
	--return io.popen([[ls -pa ./sorts | grep -v /]]):lines()
	-- https://www.reddit.com/r/lua/comments/xpqabs/how_to_list_all_files_in_a_directory/
	return io.popen([[dir ".\sorts\" /b]]):lines()
end

local function IsSorted(array)
	if #array == 0 then
		return true
	end

	for index, value in pairs(array) do
		if index == #array then
			return true
		end

		if value > array[index + 1] then
			return false
		end
	end
end

local function CloneArray(array)
	local Result = {}
	for _, value in ipairs(array) do
		table.insert(Result, value)
	end

	return Result
end

local TestCases = {
	A = { 1, 2, 4, 3 },
	B = { 4, 3, 2, 1 },
	C = { 2, 4, 2, 5 },
	D = { 0, 0, 1, 0 },
	E = { 7, 1, 2, 5, 3, 9, 4, 6, 8 },
	F = {},
	G = { 1 },
}

local function TestSort(sort_name)
	local Sorter = require("sorts." .. sort_name)

	print("Testing " .. sort_name)
	for case_name, test_array in pairs(TestCases) do
		local WorkingArray = CloneArray(test_array)
		Sorter.sort(WorkingArray)

		if IsSorted(WorkingArray) then
			print(string.format("%s -> %s (V)", StringifyArray(test_array), StringifyArray(WorkingArray)))
		else
			print(string.format("%s -> %s (X)", StringifyArray(test_array), StringifyArray(WorkingArray)))
		end
	end
end

for file_name, _ in GetSortNames() do
	TestSort(string.gsub(file_name, ".lua", ""))
end
