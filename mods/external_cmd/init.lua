-- External Command (external_cmd) mod by Menche
-- Allows server commands / chat from outside minetest
-- License: LGPL

local admin = minetest.setting_get("name")

if admin == nil then
	admin = "SERVER"
end

local xtimer=0

minetest.register_globalstep(
	function(dtime)
        xtimer = xtimer + dtime
        if xtimer < 0.5 then
            return
        end
        xtimer=0
		local f = (io.open(minetest.get_worldpath("external_cmd").."/message", "r"))
		if f ~= nil then
			local message = f:read("*line")
			f:close()
			os.remove(minetest.get_worldpath("external_cmd").."/message")

			if message ~= nil then
				local cmd, param = string.match(message, "^/([^ ]+) *(.*)")
				if not param then
					param = ""
				end
				local cmd_def = minetest.chatcommands[cmd]
				if cmd_def then
					--minetest.chat_send_all("REMOTE COMMAND: /"..cmd.." "..param)
					cmd_def.func(admin, param)
				else
					--minetest.chat_send_all("******************** ADMIN ("..admin..") says : "..message)
					minetest.chat_send_all( message )
				end
			end
		end
	end
)
