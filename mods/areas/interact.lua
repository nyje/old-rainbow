
local old_is_protected = minetest.is_protected

function minetest.is_protected(pos, name)
	if not areas:canInteract(pos, name) then
		return true
	end
	return old_is_protected(pos, name)
end

minetest.register_on_protection_violation(function(pos, name)
	if not areas:canInteract(pos, name) then
		local player = minetest.get_player_by_name(name)
		if (areas.config.hurt > 0) and player then
			player:set_hp(player:get_hp() - areas.config.hurt)
		end


		if areas.config.flip and player then
			local yaw = player:get_look_horizontal() + math.pi
			if yaw > 2 * math.pi then
				yaw = yaw - 2 * math.pi
			end
			player:set_look_horizontal(yaw)
			player:set_look_vertical(-player:get_look_vertical())
			local pla_pos = player:getpos()
			if pos.y < pla_pos.y then
				player:setpos({ x = pla_pos.x, y = pla_pos.y + 0.8, z = pla_pos.z })
			end
		end


		if areas.config.drop and player then
			local holding = player:get_wielded_item()
			if holding:to_string() ~= "" then
				-- take stack
				local sta = holding:take_item(holding:get_count())
				player:set_wielded_item(holding)
				-- incase of lag, reset stack
				minetest.after(0.1, function()
					player:set_wielded_item(holding)
					-- drop stack
					local obj = minetest.add_item(player:getpos(), sta)
					if obj then
						obj:setvelocity({x = 0, y = 5, z = 0})
					end
				end)
			end
		end


		local owners = areas:getNodeOwners(pos)
		minetest.chat_send_player(name,
			("%s is protected by %s."):format(
				minetest.pos_to_string(pos),
				table.concat(owners, ", ")))
	end
end)

