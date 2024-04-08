local GnomeSort = {}

--[[
	Sorts `array` via the gnome sorting algorithm.

	Returns the sorted `array` for convenience.
]]
function GnomeSort.sort(array)
	local Position = 1

	while Position <= #array do
		if Position == 1 or (array[Position - 1] <= array[Position]) then
			Position = Position + 1
		else
			array[Position], array[Position - 1] = array[Position - 1], array[Position]

			Position = Position - 1
		end
	end

	return array
end

return GnomeSort
