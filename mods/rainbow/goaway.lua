minetest.register_privilege("stay", {
	description = "Can not be made to go away."
})


local function away_make_formspec(pos)
	minetest.get_meta(pos):set_string("formspec", "size[9,2.5]" ..
		"field[0.3,  0;9,2;scanname;Names of players to ignore:;${scanname}]"..
		"field[0.3,1.5;4,2;radius;Radius:;${radius}]"..
		"button_exit[7,0.75;2,3;;Save]")
end

local function away_on_receive_fields(pos, _, fields)
	if not fields.scanname or not fields.radius then return false end
	local meta = minetest.get_meta(pos)
	meta:set_string("scanname", fields.scanname)
	if tonumber(fields.radius)<rainbow.config.away_radius_max then
		meta:set_int("radius", fields.radius)
	else
		meta:set_int("radius", rainbow.config.away_radius_max)
	end
	away_make_formspec(pos)
end

local function away_with_you(pos,obj)
	local name = obj:get_player_name()
	local meta = minetest.get_meta(pos)
	local opos = obj:getpos()
	local npos = { x=opos.x*2-pos.x, y=opos.y*2-pos.y, z=opos.z*2-pos.z }
	local count = 0
	local node = minetest.get_node_or_nil(npos)
	while node do
		if node.name == 'air' then
			obj:setpos(npos)
			if name ~= "" then minetest.chat_send_player(name," You may not enter this area...") end
			if count > 1 then
				if name ~= "" then  minetest.chat_send_player(name, " You were rescued from being buried "..count.." meters deep.") end
			end
			return
		elseif node.name == "ignore" then
			return
		else
			npos.y = npos.y + 1
			count = count + 1
		end
		node = minetest.get_node_or_nil(npos)
	end
end

local function away_scan(pos)
	local meta = minetest.get_meta(pos)
	local radius = meta:get_int("radius") or rainbow.config.away_radius
	local objs = minetest.get_objects_inside_radius(pos, radius)
	-- abort if no scan results were found
	if next(objs) == nil then return false end
	local scanname = meta:get_string("scanname")
	for _, obj in pairs(objs) do
		-- "" is returned if it is not a player; "" ~= nil; so only handle objects with foundname ~= ""
		local foundname = obj:get_player_name()
		if foundname ~= "" then
			local h, _ = minetest.check_player_privs(foundname, {stay = true})
			if not h then
				-- return true if player found who is not in the scanname string
				if scanname == "" or string.find(scanname,foundname)==nil then
					away_with_you(pos,obj)
					return true
				end
			end
		else
			--away_with_you(pos,obj)
			--return true
		end
	end
	return false
end

local function away_set_meta(pos,placer,istack,pt)
	local meta = minetest.get_meta(pos)
	local pn = placer:get_player_name()
	if pn then
		meta:set_string("scanname", pn )
		minetest.log("action", "Setting scanner to ignore "..pn)
		meta:set_int("radius", rainbow.config.away_radius )
	end
end

minetest.register_node("rainbow:goaway", {
	tiles = {"noentry.png"},
	paramtype = "light",
	light_source = 14,
    sunlight_propagates = true,
	walkable = true,
	groups = {cracky=3},
	description="Go Away Block",
	on_construct = away_make_formspec,
	on_receive_fields = away_on_receive_fields,
	after_place_node = away_set_meta,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'rainbow:goaway',
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
	}
})

minetest.register_abm({
	nodenames = {"rainbow:goaway"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		if not away_scan(pos) then return end
	end,
})

--minetest.register_alias("areas:away","rainbow:goaway")
