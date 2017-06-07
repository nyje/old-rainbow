local function nd_get_tiles(nd)
	if nd.tiles then
		return nd.tiles
	elseif nd.tile_images then
		return nd.tile_images
	end
	return nil
end

local function pairs_s(dict)
	local keys = {}
	for k in pairs(dict) do
		table.insert(keys, k)
	end
	table.sort(keys)
	return ipairs(keys)
end

minetest.register_chatcommand("dumpnodes", {
	params = "",
	description = "",
	func = function(plname, param)
		local n = 0
		local ntbl = {}
		for _, nn in pairs_s(minetest.registered_nodes) do
			local nd = minetest.registered_nodes[nn]
			local prefix, name = nn:match('(.*):(.*)')
			if prefix == nil or name == nil or prefix == '' or name == '' then
				print("ignored(1): " .. nn)
			else
				if ntbl[prefix] == nil then
					ntbl[prefix] = {}
				end
				ntbl[prefix][name] = nd
			end
		end
		local out, err = io.open('nodes.txt', 'wb')
		if not out then
			return true, "io.open(): " .. err
		end
		for _, prefix in pairs_s(ntbl) do
			local nodes = ntbl[prefix]
			out:write('# ' .. prefix .. '\n')
			for _, name in pairs_s(nodes) do
				local nd = nodes[name]
				if nd.drawtype ~= 'airlike' and nd_get_tiles(nd) ~= nil then
					local tl = nd_get_tiles(nd)[1]
					if type(tl) == 'table' then
						tl = tl.name
					end
					tl = (tl .. '^'):match('(.-)^')
					out:write(prefix .. ':' .. name .. ' ' .. tl .. '\n')
					n = n + 1
				else
					print("ignored(2): " .. prefix .. ':' .. name)
				end
			end
			out:write('\n')
		end
		out:close()
		return true, n .. " nodes dumped."
	end,
})
