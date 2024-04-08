local HeapSort = {}

local function Heapify(array, size, node_index)
	local Largest = node_index
	local Left = 2 * node_index
	local Right = 2 * node_index + 1

	if Left <= size and array[Left] > array[Largest] then
		Largest = Left
	end

	if Right <= size and array[Right] > array[Largest] then
		Largest = Right
	end

	if Largest ~= node_index then
		array[node_index], array[Largest] = array[Largest], array[node_index]
		Heapify(array, size, Largest)
	end
end

--[[
	Sorts `array` via the heap sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function HeapSort.sort(array)
	local Length = #array

	for i = math.floor(Length / 2), 1, -1 do
		Heapify(array, Length, i)
	end

	for i = Length, 2, -1 do
		array[i], array[1] = array[1], array[i]
		Heapify(array, i - 1, 1)
	end

	return array
end

return HeapSort
