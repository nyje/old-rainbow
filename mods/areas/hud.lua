-- This is inspired by the landrush mod by Bremaweb

areas.hud = {}


local gtimer = 0

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local pos = vector.round(player:getpos())
		local areaStrings = {}


        gtimer = gtimer + dtime;
        if gtimer >= 1 then 
            gtimer=0
            if pos.y >= 500 then
                player:set_physics_override({gravity = 0.01})
                player:override_day_night_ratio(0.8)
                player:set_sky("#102030", "plain", {})
                --player:set_attribute("skybox:skybox", skies[s][1])
            elseif pos.y >= 200 then
                player:set_physics_override({gravity=0.1})
                player:override_day_night_ratio(nil)
                player:set_sky("#101050", "plain", {})
                --player:set_attribute("skybox:skybox", skies[s][1])
            elseif pos.y <= -20 then
                player:set_physics_override({gravity=1})
                player:override_day_night_ratio(0)
                player:set_sky("#101010", "plain", {})
                --player:set_attribute("skybox:skybox", skies[s][1])
            else
                player:set_physics_override({gravity=1})
                player:override_day_night_ratio(nil)
                player:set_sky("white", "regular")
                --player:set_attribute("skybox:skybox", "off")
            end
        end

        for id, area in pairs(areas:getAreasAtPos(pos)) do
            table.insert(areaStrings, ("%s [%u] (%s%s)")
                    :format(area.name, id, area.owner,
                    area.open and ":open" or ""))
            if area.gravity then
                player:set_physics_override({gravity = area.gravity})
            end
        end
        
		for i, area in pairs(areas:getExternalHudEntries(pos)) do
			local str = ""
			if area.name then str = area.name .. " " end
			if area.id then str = str.."["..area.id.."] " end
			if area.owner then str = str.."("..area.owner..")" end
            if area.gravity then str = str.."["..area.gravity.."g]" end
			table.insert(areaStrings, str)
		end

		local areaString = "Areas:"
		if #areaStrings > 0 then
			areaString = areaString.."\n"..
				table.concat(areaStrings, "\n")
		end
		local hud = areas.hud[name]
		if not hud then
			hud = {}
			areas.hud[name] = hud
			hud.areasId = player:hud_add({
				hud_elem_type = "text",
				name = "Areas",
				number = 0xFFFFFF,
				position = {x=0, y=1},
				offset = {x=8, y=-8},
				text = areaString,
				scale = {x=200, y=60},
				alignment = {x=1, y=-1},
			})
			hud.oldAreas = areaString
			return
		elseif hud.oldAreas ~= areaString then
			player:hud_change(hud.areasId, "text", areaString)
			hud.oldAreas = areaString
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	areas.hud[player:get_player_name()] = nil
end)

