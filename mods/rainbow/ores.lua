--
-- Register ores
--
-- Clay

for _, row in ipairs(rainbow.colours) do
    minetest.register_ore({
        ore_type        = "blob",
        ore             = "rainbow:clay_"..row[1],
        wherein         = {"rainbow:sand_"..row[1]},
        clust_scarcity  = 16 * 16 * 16,
        clust_size      = 5,
        y_min           = -15,
        y_max           = 0,
        noise_threshold = 0.0,
        noise_params    = {
            offset = 0.5,
            scale = 0.2,
            spread = {x = 5, y = 5, z = 5},
            seed = -316,
            octaves = 1,
            persist = 0.0
        },
    })

    -- Silver sand

    minetest.register_ore({
        ore_type        = "blob",
        ore             = "rainbow:sand_"..row[1],
        wherein         = {"rainbow:stone_"..row[1]},
        clust_scarcity  = 16 * 16 * 16,
        clust_size      = 5,
        y_min           = -31000,
        y_max           = 31000,
        noise_threshold = 0.0,
        noise_params    = {
            offset = 0.5,
            scale = 0.2,
            spread = {x = 5, y = 5, z = 5},
            seed = 2316,
            octaves = 1,
            persist = 0.0
        },
    })

    -- Dirt

    minetest.register_ore({
        ore_type        = "blob",
        ore             = "rainbow:dirt_"..row[1],
        wherein         = {"rainbow:stone_"..row[1]},
        clust_scarcity  = 16 * 16 * 16,
        clust_size      = 5,
        y_min           = -31,
        y_max           = 31000,
        noise_threshold = 0.0,
        noise_params    = {
            offset = 0.5,
            scale = 0.2,
            spread = {x = 5, y = 5, z = 5},
            seed = 17676,
            octaves = 1,
            persist = 0.0
        },
    })

    -- Gravel

    minetest.register_ore({
        ore_type        = "blob",
        ore             = "rainbow:gravel_"..row[1],
        wherein         = {"rainbow:stone_"..row[1]},
        clust_scarcity  = 16 * 16 * 16,
        clust_size      = 5,
        y_min           = -31000,
        y_max           = 31000,
        noise_threshold = 0.0,
        noise_params    = {
            offset = 0.5,
            scale = 0.2,
            spread = {x = 5, y = 5, z = 5},
            seed = 766,
            octaves = 1,
            persist = 0.0
        },
    })
end

-- Scatter ores

local add_ore = function(a,b,c,d,e,f,g)
    minetest.register_ore({
        ore_type="scatter",
        ore=a,
        wherein=b,
        clust_scarcity = c,
        clust_num_ores = d,
        clust_size     = e,
        y_min          = f,
        y_max          = g,
        })
end

for _, row in ipairs(rainbow.colours) do
    add_ore("rainbow:coalore_"..row[1], "rainbow:stone_"..row[1], 8*8*8, 9, 3, -31000, 31000)
    add_ore("rainbow:coalore_"..row[1], "rainbow:stone_"..row[1], 24*24*24, 27, 6, -31000, 31000)
    add_ore("rainbow:ironore_"..row[1], "rainbow:stone_"..row[1],  24*24*24, 27, 6, -31000, 31000)
    add_ore("rainbow:copperore_"..row[1], "rainbow:stone_"..row[1], 12*12*12, 5, 3, -31000,31000)
    add_ore("rainbow:goldore_"..row[1], "rainbow:stone_"..row[1], 13*13*13, 5, 3, -31000,31000)
    add_ore("rainbow:meseore_"..row[1], "rainbow:stone_"..row[1], 14*14*14, 5, 3, -31000,31000)
    add_ore("rainbow:diamondore_"..row[1], "rainbow:stone_"..row[1], 15*15*15, 4, 3, -31000,31000)
end
