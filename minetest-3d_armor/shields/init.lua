local use_moreores = minetest.get_modpath("moreores")

-- Regisiter Shields

minetest.register_tool("shields:shield_admin", {
	description = "Admin Shield ",
	inventory_image = "shields_inv_shield_admin.png",
	groups = {armor_shield=1000, armor_heal=100, armor_use=0, not_in_creative_inventory=1},
	wear = 0,
})

if ARMOR_MATERIALS.diamond then
	minetest.register_tool("shields:shield_diamond", {
		description = "Diamond Shield 15-12",
		inventory_image = "shields_inv_shield_diamond.png",
		groups = {armor_shield=15, armor_heal=12, armor_use=250},
		wear = 0,
	})
end

if ARMOR_MATERIALS.gold then
	minetest.register_tool("shields:shield_gold", {
		description = "Gold Shield 15-0",
		inventory_image = "shields_inv_shield_gold.png",
		groups = {armor_shield=15, armor_heal=0, armor_use=100},
		wear = 0,
	})
end

if ARMOR_MATERIALS.bronze then
	minetest.register_tool("shields:shield_bronze", {
		description = "Bronze Shield 12-9",
		inventory_image = "shields_inv_shield_bronze.png",
		groups = {armor_shield=12, armor_heal=9, armor_use=500},
		wear = 0,
	})
end

if ARMOR_MATERIALS.steel then
	minetest.register_tool("shields:shield_steel", {
		description = "Steel Shield 12-0",
		inventory_image = "shields_inv_shield_steel.png",
		groups = {armor_shield=12, armor_heal=0, armor_use=250},
		wear = 0,
	})
end

if ARMOR_MATERIALS.wood then
	minetest.register_tool("shields:shield_wood", {
		description = "Wooden Shield 6-0",
		inventory_image = "shields_inv_shield_wood.png",
		groups = {armor_shield=6, armor_heal=0, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("shields:shield_enhanced_wood", {
		description = "Enhanced Wood Shield 9-6",
		inventory_image = "shields_inv_shield_enhanced_wood.png",
		groups = {armor_shield=9, armor_heal=6, armor_use=1000},
		wear = 0,
	})
	minetest.register_craft({
		output = "shields:shield_enhanced_wood",
		recipe = {
			{"default:steel_ingot"},
			{"shields:shield_wood"},
			{"default:steel_ingot"},
		},
	})
end

if ARMOR_MATERIALS.cactus then
	minetest.register_tool("shields:shield_cactus", {
		description = "Cactus Shield 6-0",
		inventory_image = "shields_inv_shield_cactus.png",
		groups = {armor_shield=6, armor_heal=0, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("shields:shield_enhanced_cactus", {
		description = "Enhanced Cactus Shield 9-6",
		inventory_image = "shields_inv_shield_enhanced_cactus.png",
		groups = {armor_shield=9, armor_heal=6, armor_use=1000},
		wear = 0,
	})
	minetest.register_craft({
		output = "shields:shield_enhanced_cactus",
		recipe = {
			{"default:steel_ingot"},
			{"shields:shield_cactus"},
			{"default:steel_ingot"},
		},
	})
end

for k, v in pairs(ARMOR_MATERIALS) do
	minetest.register_craft({
		output = "shields:shield_"..k,
		recipe = {
			{v, v, v},
			{v, v, v},
			{"", v, ""},
		},
	})
end

minetest.after(0, function()
	table.insert(armor.elements, "shield")
end)

