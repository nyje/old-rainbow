local path = rainbow.modpath .. "/schematics/"

local add_schem = function(a, b, c, d, e, f)
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = a,
		sidelen = 80,
		fill_ratio = b,
		biomes = c,
		y_min = d,
		y_max = e,
		schematic = f,
		flags = "place_center_x, place_center_z",
        rotation = "random",
	})
end

local add_deco = function(a,b,c,d,e,f,g)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = a,
        biomes = b,
		sidelen = c,
        fill_ratio = d,
		y_min = e,
		y_max = f,
		decoration = g,
	})
end

local add_grass = function(a,b,c)
    for i = 1, 5 do
        add_deco({"group:dirt"},a,16,c,0,31000,"rainbow:grass"..i.."_"..b)
    end
end


minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:dirt","group:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	y_min = 0,
	y_max = 0,
	schematic = path.."papyrus.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.4,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
    biomes = {"lightgreen"},
	y_min = 1,
	y_max = 31000,
	schematic = path.."papyrus.mts",
})

add_schem({"group:dirt","group:sand"}, 0.005, nil, 0, 0, path.."waterlily.mts")
add_schem({"group:dirt"}, 0.0005, nil, 1, 100, path .. "lamp.mts")
add_deco({"group:dirt"},rainbow.high_biomes,16,0.1,0,31000,"rainbow:daisies")
add_grass(nil,"black",0.001)
add_grass(nil,"darkgrey",0.001)
add_grass(nil,"grey",0.001)
add_grass(nil,"white",0.001)



add_schem({"group:dirt"}, 0.0001, {"cyan"}, 1, 100, path .. "bluewood.mts")
add_schem({"group:dirt"}, 0.0003, {"cyan"}, 1, 100, path .. "bluewoodmedium.mts")
add_schem({"group:dirt"}, 0.0006, {"cyan","cyan_high"}, 1, 100, path .. "bluewood_small.mts")
add_schem({"group:dirt"}, 0.001, {"cyan"}, 1, 100, path .. "icehouse.mts")
add_deco({"group:dirt"},{'cyan','cyan_high'},16,0.01,0,31000,"rainbow:tulip")
add_grass({'cyan','cyan_high'},"cyan",0.05)
add_grass({'cyan','cyan_high'},"grey",0.05)


add_schem({"group:dirt"}, 0.005,  {"magenta"}, 1, 100, path .. "tree_magenta.mts")
add_schem({"group:dirt"}, 0.001,  {"magenta"}, 1, 100, path .. "pinkandblackhouse2.mts")
add_deco({"group:dirt"},{'magenta','magenta_high'},16,0.01,0,31000,"rainbow:dianthus")
add_grass({'magenta','magenta_high'},"violet",0.05)
add_grass({'magenta','magenta_high'},"magenta",0.05)


add_schem({"group:dirt"}, 0.003,  {"violet"}, 1, 100, path .. "mushroom.mts")
add_schem({"group:dirt"}, 0.003,  {"violet","violet_high"}, 1, 100, path .. "mushroom_fork.mts")
add_schem({"group:dirt"}, 0.03,   {"violet","violet_high"}, 1, 100, path .. "mushroom_small.mts")
add_grass({'violet','violet_high'},"magenta",0.05)
add_grass({'violet','violet_high'},"violet",0.05)
add_deco({"group:dirt"},{'violet','violet_high'},16,0.01,0,31000,"rainbow:violet")

--add_schem({"group:dirt"}, 0.001, {"lightgreen"}, 1, 100, path .. "bigtree.mts")
add_grass({'lightgreen','lightgreen_high'},"green",0.05)
add_grass({'lightgreen','lightgreen_high'},"lightgreen",0.05)
add_deco({"group:dirt"},{'lightgreen','lightgreen_high'},80,0.01,0,31000,"rainbow:greenery")


add_schem({"group:dirt"}, 0.001, {"green"}, 1, 100, path .. "bigtree.mts")
add_grass({'green','green_high'},"lightgreen",0.05)
add_grass({'green','green_high'},"green",0.05)
add_deco({"group:dirt"},{'green','green_high'},80,0.01,0,31000,"rainbow:junglegrass")


add_schem({"group:dirt"}, 0.005, {"red","red_high","black"}, 1, 100, path .. "tree_red.mts")
add_schem({"group:dirt"}, 0.002, {"red"}, 1, 100, path .. "volcanolarge.mts")
add_schem({"group:dirt"}, 0.005, {"red","red_high"}, 1, 100, path .. "volcanosmall.mts")
add_grass({'red','red_high'},"red",0.05)
add_grass({'red','red_high'},"black",0.05)
add_deco({"group:dirt"},{'red','red_high'},16,0.01,0,31000,"rainbow:mushroom_red")

add_schem({"group:dirt"}, 0.001, {"orange"}, 1, 100, path .. "meteora.mts")
add_schem({"group:dirt"}, 0.0005, {"orange","orange_high"}, 1, 100, path .. "pod.mts")
add_grass({'orange','orange_high'},"brown",0.05)
add_grass({'orange','orange_high'},"orange",0.05)
add_deco({"group:dirt"},{'orange','orange_high'},16,0.01,0,31000,"rainbow:orangeflower")

add_schem({"group:dirt"}, 0.0005, {"black"}, 1, 100, path .. "cheese_balloon_black.mts")
add_schem({"group:dirt"}, 0.005, {"black"}, 1, 100, path .. "tree_black.mts")
add_grass({'black','black_high'},"darkgrey",0.05)
add_grass({'black','black_high'},"grey",0.05)
add_grass({'black','black_high'},"black",0.05)

add_schem({"group:dirt"}, 0.0001, {"pink"}, 1, 100, path .. "giantrose.mts")
add_deco({"group:dirt"},{'pink','pink_high'},16,0.01,0,31000,"rainbow:rose")
add_grass({'pink','pink_high'},"grey",0.05)
add_grass({'pink','pink_high'},"pink",0.05)

add_deco({"group:dirt"},{'yellow','yellow_high'},16,0.01,0,31000,"rainbow:dandelion")
add_grass({'yellow','yellow_high'},"lightgreen",0.05)
add_grass({'yellow','yellow_high'},"yellow",0.05)

add_schem({"group:dirt"}, 0.003, {"blue"}, 1, 100, path .. "bluewoodmedium.mts")
add_schem({"group:dirt"}, 0.005, {"blue"}, 1, 100, path .. "tree_blue.mts")
add_schem({"group:dirt"}, 0.006, {"blue","blue_high"}, 1, 100, path .. "bluewood_small.mts")
add_deco({"group:dirt"},{'blue','blue_high'},16,0.01,0,31000,"rainbow:geranium")
add_grass({'blue','blue_high'},"cyan",0.05)
add_grass({'blue','blue_high'},"blue",0.05)

add_schem({"group:dirt"}, 0.005, {"brown"}, 1, 100, path .. "brownspike.mts")
add_schem({"group:dirt"}, 0.0001, {"brown"}, 1, 100, path .. "ufo.mts")
add_deco({"group:dirt"},{'brown','brown_high'},16,0.01,0,31000,"rainbow:mushroom_brown")
add_grass({'brown','brown_high'},"green",0.05)
add_grass({'brown','brown_high'},"brown",0.05)

add_schem({"group:dirt"}, 0.001, {"darkgrey"}, 1, 100, path .. "darkgreygazebo.mts")
add_schem({"group:dirt"}, 0.001, {"darkgrey"}, 1, 100, path .. "tree_glass.mts")
add_grass({'darkgrey','darkgrey_high'},"green",0.05)
add_grass({'darkgrey','darkgrey_high'},"darkgrey",0.05)
add_deco({"group:dirt"},{"darkgrey","darkgrey_high"},16,0.1,0,31000,"rainbow:cookieflower")

