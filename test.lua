local function StringifyArray(array)
	return "{" .. table.concat(array, ", ") .. "}"
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
	-- Shuffled number cases
	ShuffleA = { 1, 2, 4, 3 },
	ShuffleB = { 7, 1, 2, 5, 3, 9, 4, 6, 8 },
	ShuffleC = { 1, 3, 5, 7, 9, 2, 4, 6, 8, 10, 11, 13, 15, 12, 14 },
	ShuffleD = { -4, 0, 2, -2, 4 },
	ShuffleE = { -1, 7, 65, 16, -12 },
	ShuffleF = { -90, -30, -60, -20, 0 },

	-- Duplicated number cases
	DuplicatedA = { 2, 5, 5, 4 },
	DuplicatedB = { 0, 0, 1, 0 },
	DuplicatedC = { -5, -12, -5, -6 },
	DuplicatedD = { -2, -2, 6, 0, 8, 8 },

	-- Special cases
	SpecialSorted = { 1, 2, 3, 4 },
	SpecialReversed = { 4, 3, 2, 1 },
	SpecialEmpty = {},
	SpecialOnePositive = { 1 },
	SpecialOneNegative = { -1 },
	SpecialZero = { 0 },
}

local TestedCounter = 0
local TestResult = {}

local function PrintTestResult(case_name, original_array, result, is_completed, is_a_success)
	local Checkmark = "X"
	if is_a_success then
		Checkmark = "V"
	end

	if is_completed then
		print(
			string.format(
				"%s: %s -> %s (%s)",
				case_name,
				StringifyArray(original_array),
				StringifyArray(result),
				Checkmark
			)
		)
	else
		print(string.format("%s: %s -> ERROR (%s)", case_name, StringifyArray(original_array), result))
	end
end

local function TestSort(sort_name)
	local Sorter = require("sorts." .. sort_name)
	local SuccessCases = {}
	local TestedCases = {}
	local FailedCases = {}

	TestedCounter = TestedCounter + 1
	print(string.format("#%i Testing %s", TestedCounter, sort_name))
	for case_name, test_array in pairs(TestCases) do
		local Completed, Result = pcall(function()
			return Sorter.sort(CloneArray(test_array))
		end)

		local Success = false
		if Completed then
			Success = IsSorted(Result)
		end

		table.insert(TestedCases, case_name)
		if Success then
			table.insert(SuccessCases, case_name)
		else
			table.insert(FailedCases, case_name)
		end

		PrintTestResult(case_name, test_array, Result, Completed, Success)
	end

	local EndString = ""
	if #SuccessCases == #TestedCases then
		EndString = " (All passed!)"
	end
	print(string.format("Test completed (%i/%i)%s", #SuccessCases, #TestedCases, EndString))

	table.insert(TestResult, {
		SortingAlgorithm = sort_name,
		TestedCases = TestedCases,
		SuccessCases = SuccessCases,

		FailedCases = FailedCases,
	})
end

local function PrintSummary()
	print("=-=-=-=-=-=-= SUMMARY =-=-=-=-=-=-=")
	for index, test_result in pairs(TestResult) do
		local Summary = string.format(
			"#%i %s: %i/%i",
			index,
			test_result.SortingAlgorithm,
			#test_result.SuccessCases,
			#test_result.TestedCases
		)

		if #test_result.FailedCases > 0 then
			Summary = Summary .. string.format(" (Failed cases: %s)", table.concat(test_result.FailedCases, ", "))
		end
		print(Summary)
	end
end

for file_name, _ in GetSortNames() do
	print("\n")
	TestSort(string.gsub(file_name, ".lua", ""))
end

print("\n")
PrintSummary()
print("\n")
