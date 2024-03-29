-- local door_wood = { -- color, desc, image
-- 	{"red", "Red Stained", "red"},
-- 	{"grey", "Grey Stained", "grey"},
-- 	{"dark_grey", "Dark Grey Stained", "dark_grey"},
-- 	{"brown", "Brown Stained", "brown"},
-- 	{"white", "White Stained", "white"},
-- 	{"yellow", "Clear Stained", "yellow"},
-- 	{"black", "Black", "black"},
-- }
-- for i in ipairs(door_wood) do
-- 	local color = door_wood[i][1]
-- 	local desc = door_wood[i][2]
-- 	local img = door_wood[i][3]
--

-- minetest.register_node("my_door_wood:wood_"..color, {
-- 	description = desc.." Wood",
-- 	drawtype = "normal",
-- 	paramtype = "light",
-- 	tiles = {"mydoors_"..img.."_wood.png"},
-- 	paramtype = "light",
-- 	groups = {cracky = 2, choppy = 2},
--
-- })
--
-- -- Crafts
--
-- minetest.register_craft({
-- 	output = "my_door_wood:wood_"..color,
-- 	recipe = {
-- 		{"default:wood", "", ""},
-- 		{"dye:"..color, "", ""},
-- 		{"", "", ""}
-- 	}
-- })
-- end

minetest.register_alias("my_door_wood:wood_red", "rainbow:wood_red")
minetest.register_alias("my_door_wood:wood_grey", "rainbow:wood_grey")
minetest.register_alias("my_door_wood:wood_dark_grey", "rainbow:wood_darkgrey")
minetest.register_alias("my_door_wood:wood_brown", "rainbow:wood_brown")
minetest.register_alias("my_door_wood:wood_white", "rainbow:wood_white")
minetest.register_alias("my_door_wood:wood_yellow", "rainbow:wood_yellow")
minetest.register_alias("my_door_wood:wood_black", "rainbow:wood_black")