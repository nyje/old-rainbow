for _, row in ipairs(rainbow.colours) do
    minetest.register_alias("wool:"..row[1],"rainbow:wool_"..row[1])
end
