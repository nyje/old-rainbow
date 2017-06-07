--[[
More Blocks: circular saw

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = moreblocks.intllib

circular_saw = {}

circular_saw.known_stairs = setmetatable({}, {
	__newindex = function(k, v)
		local modname = minetest.get_current_modname()
		print(("WARNING: mod %s tried to add node %s to the circular saw"
				.. " manually."):format(modname, v))
	end,
})

-- This is populated by stairsplus:register_all:
circular_saw.known_nodes = {}

-- How many microblocks does this shape at the output inventory cost:
-- It may cause slight loss, but no gain.
circular_saw.cost_in_microblocks = {
	1, 1, 1, 1, 1, 1, 1, 2,
	2, 3, 2, 4, 2, 4, 5, 6,
	7, 1, 1, 2, 4, 6, 7, 8,
	3, 1, 1, 2, 4, 4, 2, 6,
	7, 3, 7, 7, 4, 8, 3, 2,
	6, 2, 1, 3, 4,
}

circular_saw.names = {
	{"micro", "_1"},
	{"panel", "_1"},
	{"micro", "_2"},
	{"panel", "_2"},
	{"micro", "_4"},
	{"panel", "_4"},
	{"micro", ""},
	{"panel", ""},
	{"micro", "_12"},
	{"panel", "_12"},
	{"micro", "_14"},
	{"panel", "_14"},
	{"micro", "_15"},
	{"panel", "_15"},
	{"stair", "_outer"},
	{"stair", ""},
	{"stair", "_inner"},
	{"slab", "_1"},
	{"slab", "_2"},
	{"slab", "_quarter"},
	{"slab", ""},
	{"slab", "_three_quarter"},
	{"slab", "_14"},
	{"slab", "_15"},
	{"stair", "_half"},
	{"stair", "_alt_1"},
	{"stair", "_alt_2"},
	{"stair", "_alt_4"},
	{"stair", "_alt"},
	{"slope", ""},
	{"slope", "_half"},
	{"slope", "_half_raised"},
	{"slope", "_inner"},
	{"slope", "_inner_half"},
	{"slope", "_inner_half_raised"},
	{"slope", "_inner_cut"},
	{"slope", "_inner_cut_half"},
	{"slope", "_inner_cut_half_raised"},
	{"slope", "_outer"},
	{"slope", "_outer_half"},
	{"slope", "_outer_half_raised"},
	{"slope", "_outer_cut"},
	{"slope", "_outer_cut_half"},
	{"slope", "_outer_cut_half_raised"},
	{"slope", "_cut"},
}

function circular_saw:get_cost(inv, stackname)
	for i, item in pairs(inv:get_list("output")) do
		if item:get_name() == stackname then
			return circular_saw.cost_in_microblocks[i]
		end
	end
end

function circular_saw:get_output_inv(modname, material, amount, max)
	if (not max or max < 1 or max > 99) then max = 99 end

	local list = {}
	local pos = #list

	-- If there is nothing inside, display empty inventory:
	if amount < 1 then
		return list
	end

	for i = 1, #circular_saw.names do
		local t = circular_saw.names[i]
		local cost = circular_saw.cost_in_microblocks[i]
		local balance = math.min(math.floor(amount/cost), max)
		local nodename = modname .. ":" .. t[1] .. "_" .. material .. t[2]
		if  minetest.registered_nodes[nodename] then
			pos = pos + 1
			list[pos] = nodename .. " " .. balance
		end
	end
	return list
end

