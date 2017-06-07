local disallowed = {
	["^guest"]			=	"Temporary 'GuestXXXX' usernames are disallowed on this server.  "..
						"Please choose a proper username and try again.",
	["^player"]			=	"Temporary 'PlayerXXXX' usernames are disallowed on this server.  "..
						"Please choose a proper username and try again.",
	["^squeakecraft"]		=	"Temporary 'Squeakecraft' usernames are disallowed on this server.  "..
						"Please choose a proper username and try again.",
	["[4a]dm[1il]n"]		=	"That is a clearly false, misleading, or otherwise disallowed username. "..
						"Please choose a unique username and try again.",
	["^[0-9]+$"]			=	"All-numeric usernames are disallowed on this server. "..
						"Please choose a proper username and try again.",
	["[0-9]"] 	=	"Numbers in your username. "..
						"This is a building community server, use a proper name and behave."
}

-- Original implementation (in Python) by sfan5
local function judge(msg)
	local numspeakable = 0
	local numnotspeakable = 0
	local cn = 0
	local lastc = '____'
	for c in msg:gmatch(".") do
		c = c:lower()
		if c:find("[aeiou0-9_-]") then
			if cn > 2 and not c:find("[0-9]") then
				numnotspeakable = numnotspeakable + 1
			elseif not c:find("[0-9]") then
				numspeakable = numspeakable + 1
			end
			cn = 0
		else
			if (cn == 1) and (lastc == c) and (lastc ~= 's') then
				numnotspeakable = numnotspeakable + 1
				cn = 0
			end
			if cn > 2 then
				numnotspeakable = numnotspeakable + 1
				cn = 0
			end
			if lastc:find("[aeiou]") then
				numspeakable = numspeakable + 1
				cn = 0
			end
			if not ((lastc:find("[aipfom]") and c == "r") or (lastc == "c" and c == "h")) then
				cn = cn + 1
			end
		end
		lastc = c
	end
	if cn > 0 then
		numnotspeakable = numnotspeakable + 1
	end
	return (numspeakable >= numnotspeakable)
end

minetest.register_on_prejoinplayer(function(name, ip)
	local lname = name:lower()
	for re, reason in pairs(disallowed) do
		if lname:find(re) and not minetest.auth_table[name] then
			return reason
		end
	end

	if #name < 2 then
		return "Too short of a username. "..
				"Please pick a name with at least two letters and try again."
	end

	if not judge(name) and #name > 5 then
		return "Your username just plain looks like gibberish. "..
				"Please pick something readable and try again."
	end

end)

minetest.register_on_prejoinplayer(function(name, ip)
	local lname = name:lower()
	for iname, data in pairs(minetest.auth_table) do
		if iname:lower() == lname and iname ~= name then
			return "Sorry, someone else is already using this "
				.."name, or maybe you mistyped it?  Please "
				.."check your typing or pick another name."
		end
	end
end)

minetest.register_chatcommand("choosecase", {
	description = "Choose the casing that a player name should have",
	params = "<name>",
	privs = {server=true},
	func = function(name, params)
		local lname = params:lower()
		local worldpath = minetest.get_worldpath()
		for iname, data in pairs(minetest.auth_table) do
			if iname:lower() == lname and iname ~= params then
				minetest.auth_table[iname] = nil
				assert(not iname:find("/"))
				os.remove(worldpath.."/players/"..iname)
			end
		end
		minetest.chat_send_player(name, "Done.")
	end,
})
