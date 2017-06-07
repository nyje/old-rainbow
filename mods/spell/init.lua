-- spell  server management & toys
-- Created for Elektra's Creative Server
-- Contains code derived from "Jail Mod" By kaeza and RAPHAEL (mostly kaeza)
-- Extended by Nigel Garnett starting 2015-08-21
-- license: see license.txt


--------------------------------------------------------
--    local variables

local modname = "spell:"
local characters = {
    A = 1,
    B = 1,
    C = 1,
    D = 1,
    E = 1,
    F = 1,
    G = 1,
    H = 1,
    I = 1,
    J = 1,
    K = 1,
    L = 1,
    M = 1,
    N = 1,
    O = 1,
    P = 1,
    Q = 1,
    R = 1,
    S = 1,
    T = 1,
    U = 1,
    V = 1,
    W = 1,
    X = 1,
    Y = 1,
    Z = 1,
    [0] = 0,
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0
}
local spawn = {x = 0, y = 2, z = 0}
local jail_data = {}

local players_in_jail = { };

--------------------------------------------------------
--    local functions

local function table_empty(tab)
	for key in pairs(tab) do return false end
	return true
end

local function save_data ()
	if table_empty(jail_data) then
        return
    end
	local data = minetest.serialize( jail_data )
	local path = minetest.get_worldpath().."/jail.data"
	local file = io.open( path, "w" )
	if( file ) then
		file:write( data )
		file:close()
		return true
	else return nil
	end
end

local function load_data ()
	local path = minetest.get_worldpath().."/jail.data"
	local file = io.open( path, "r" )
	if( file ) then
		local data = file:read("*all")
		jail_data = minetest.deserialize( data )
		file:close()
		if table_empty(jail_data) then
            os.remove(path)
        end
	return true
	else return nil
	end
end

-- Jail Handler
local function do_teleport ( )
    for name, player in pairs(players_in_jail) do
            player:setpos(jail_data.jailpos)
    end
    minetest.after(15, do_teleport)
end
minetest.after(15, do_teleport)


if not load_data() then
    jail_data.jailpos = { x = 2008, y = 809, z = 1978 }
    jail_data.releasepos = { x = 143, y = 6, z = 56 }
end

------------------------------------------------------
-- Register stuff with the game engine

-- Set a nice hud size
minetest.register_on_joinplayer(function(player)
    minetest.after(0, player.hud_set_hotbar_itemcount, player, 16)
end)

-- Privs
minetest.register_privilege("jail", { description = "Allows one to send/release prisoners" })
minetest.register_privilege("setjail", { description = "Allows one to set the jail position and the release position" })
--minetest.register_privilege("setspawn", { description = "Allows one to set the spawn position." })





minetest.register_chatcommand("setjail", {
    description = "Set the position of the Jail to where you are now. by Nigel for Sasha5.",
	privs = {setjail=true},
    func = function ( name, param )
        jail_data.jailpos = minetest.get_player_by_name(name):getpos()
        save_data()
        return true, "Jail position set."
    end,
})

minetest.register_chatcommand("setrelease", {
    description = "Set the release position to where you are now. by Nigel for Sasha5.",
	privs = {setjail=true},
    func = function ( name, param )
        jail_data.releasepos = minetest.get_player_by_name(name):getpos()
        save_data()
        return true, "Release position Set."
    end,
})

minetest.register_chatcommand("jail", {
    params = "<player>",
    description = "Sends a player to Jail",
	privs = {jail=true},
    func = function ( name, param )
        local player = minetest.get_player_by_name(param)
        if (player) then
            players_in_jail[param] = player;
            player:setpos(jail_data.jailpos)
			minetest.chat_send_player(param, "You have been sent to jail")
			minetest.chat_send_all(""..param.." has been sent to jail by "..name.."")
        end
    end,
})

minetest.register_chatcommand("release", {
    params = "<player>",
    description = "Releases a player from Jail",
	privs = {jail=true},
    func = function ( name, param )
        if (param == "") then return end
        local player = minetest.get_player_by_name(param)
        players_in_jail[param] = nil;
        if (player) then
            player:setpos(jail_data.releasepos)
			minetest.chat_send_player(param, "You have been released from jail")
			minetest.chat_send_all(""..param.." has been released from jail by "..name.."")
        end
    end,
})

minetest.register_chatcommand("spawn", {
    description = "Teleport player to spawn point.",
	privs = {interact=true},
    func = function ( name, param )
        local player = minetest.get_player_by_name(name)
        minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
        player:setpos(spawn)
        return true
    end,
})

minetest.register_chatcommand("afk", {
    description = "Tell everyone you are afk.",
    func = function ( name, param )
        local player = minetest.get_player_by_name(name)
        minetest.chat_send_all(name.." is AFK! ")
        return true
    end,
})



----------------------------------------------------------
-- Register Nodes

for key,value in pairs(characters) do
    if value==1 then
        my_desc = "Letter_"..key
        minetest.register_node(modname.."Sign_"..key, {
            description="Sign "..my_desc,
            drawtype = "nodebox",
            node_box = {
                type = "wallmounted",
                wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
                wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
                wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
            },
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            light_source = 14,
            inventory_image = "sign_"..key..".png",
            wield_image = "sign_"..key..".png",
            tiles = { "sign_"..key..".png" },
            groups = {cracky=1, choppy=1},
            sounds = default.node_sound_wood_defaults(),
        })
    else
        my_desc = "Number_"..key
    end
	minetest.register_node(modname.."Letter_"..key, {
        description="Block"..my_desc,
		tiles = { "spell_"..key..".png" },
		light_source = 14,
        inventory_image = "spell_"..key..".png",
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

-- 	minetest.register_node("spell:glaz", {
-- 		description = "Invisible Glass",
-- 		drawtype = "glasslike_framed_optional",
-- 		tiles = {"glaz.png"},
-- 		inventory_image = minetest.inventorycube("glaz.png"),
-- 		paramtype = "light",
-- 		sunlight_propagates = true,
-- 		is_ground_content = false,
-- 		groups = {cracky = 3, oddly_breakable_by_hand = 3},
-- 		sounds = default.node_sound_glass_defaults(),
-- 	})

	minetest.register_node(modname.."px_logo", {
        description="planet express logo",
		tiles = { "PX.png" },
		light_source = 14,
        inventory_image = "PX.png",
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(modname.."nigel", {
        description="Nigel",
        drawtype = "nodebox",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
            wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
            wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
        },

    	paramtype = "light",
    	paramtype2 = "wallmounted",
        wield_image = "nyje_nyje.png",
        sunlight_propagates = true,
        tiles = { "nyje_nyje.png" },
		light_source = 14,
        inventory_image = "nyje_nyje.png",
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	})


	minetest.register_node(modname.."elektra", {
        description="Elektra",
        drawtype = "nodebox",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
            wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
            wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
        },
    	paramtype = "light",
    	paramtype2 = "wallmounted",
        wield_image = "nyje_elektra.png",
        sunlight_propagates = true,
        tiles = { "nyje_elektra.png" },
		light_source = 14,
        inventory_image = "nyje_elektra.png",
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	})


-- 	minetest.register_node(modname.."lebes", {
--         description="Lojas Lebes",
--         drawtype = "nodebox",
--         node_box = {
--             type = "wallmounted",
--             wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
--             wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
--             wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
--         },
--     	paramtype = "light",
--     	paramtype2 = "wallmounted",
--         wield_image = "lebes.png",
--         sunlight_propagates = true,
--         tiles = { "lebes.png" },
-- 		light_source = 14,
--         inventory_image = "lebes.png",
-- 		groups = {cracky=3, choppy=3},
-- 		sounds = default.node_sound_stone_defaults(),
-- 	})


-- 	minetest.register_node(modname.."PhilosoPhia_Agatha", {
--         description="PhilosoPhia_Agatha",
--         drawtype = "nodebox",
--         node_box = {
--             type = "wallmounted",
--             wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
--             wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
--             wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
--         },
--     	paramtype = "light",
--     	paramtype2 = "wallmounted",
--         wield_image = "will.png",
--         sunlight_propagates = true,
--         tiles = { "will.png" },
-- 		light_source = 14,
--         inventory_image = "will.png",
-- 		groups = {cracky=3, choppy=3},
-- 		sounds = default.node_sound_stone_defaults(),
-- 	})


	minetest.register_node(modname.."dangersign", {
        description="Danger Of Death Sign",
        drawtype = "nodebox",
        node_box = {
            type = "wallmounted",
            wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
            wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
            wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
        },
    	paramtype = "light",
    	paramtype2 = "wallmounted",
        wield_image = "dds.png",
        sunlight_propagates = true,
        tiles = { "dds.png" },
		light_source = 14,
        inventory_image = "dds.png",
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	})











-------------------------------------------------------------------
-- alias away old mod stuff to keep tyhe map tidy


--minetest.register_alias("mobs:egg", "air")
--minetest.register_alias("candycane:candy_block", "stone")
--for i = 1, 15 do
--	minetest.register_alias("xpanes:pane_"..i, "air")
--end




-------------------------------------------------------------------
-- END OF LIVE CODE SECTION
-------------------------------------------------------------------


-------------------------------------------------------------------
-- Disabled & held code only after this

-- minetest.register_alias("wardenpick", "jail:pick_warden")
--
-- minetest.register_node("jail:jailwall", {
-- 	description = "Unbreakable Jail Wall",
-- 	tiles = {"jail_wall.png"},
-- 	is_ground_content = true,
-- 	groups = {unbreakable=1},
-- --	sounds = default.node_sound_stone_defaults(),
-- })
--
-- minetest.register_node("jail:glass", {
-- 	description = "Unbreakable Jail Glass",
-- 	drawtype = "glasslike",
-- 	tiles = {"jail_glass.png"},
-- 	paramtype = "light",
-- 	sunlight_propagates = true,
-- 	is_ground_content = true,
-- 	groups = {unbreakable=1},
-- --	sounds = default.node_sound_glass_defaults(),
-- })
--
-- minetest.register_node("jail:ironbars", {
-- 	drawtype = "fencelike",
-- 	tiles = {"jail_ironbars.png"},
-- 	inventory_image = "jail_ironbars.png",
-- 	light_propagates = true,
-- 	paramtype = "light",
-- 	is_ground_content = true,
-- 	selection_box = {
-- 		type = "fixed",
-- 		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
-- 	},
-- 	groups = {unbreakable=1},
-- --	sounds = default.node_sound_stone_defaults(),
-- })
--
-- minetest.register_tool("jail:pick_warden", {
-- 	description = "Warden Pickaxe",
-- 	inventory_image = "jail_wardenpick.png",
-- 	tool_capabilities = {
-- 		full_punch_interval = 0,
-- 		max_drop_level=3,
-- 		groupcaps={
-- 			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
-- 		}
-- 	},
-- })


