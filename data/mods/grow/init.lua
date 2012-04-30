math.randomseed(os.time())

--[[
-- The growable table is to be used as following:
--   name describes the node that is to grow
--   surfaces is a table of:
--     the name of the node the said node is allowed to grow
--     the odds it has over 1000 to grow at each callback cycle
--]]
growable = {
    {
        name = "papyrus",
        surfaces = {
            -- Papyrus will grow normally on dirt,
            -- it has 50/1000 chances of growing on a cycle
            {name = "dirt", odds = 50, max_height = 3},
            -- Papyrus won't grow very well on sand
            {name = "sand", odds = 10, max_height = 3}
        }
    },
    {
        name = "cactus",
        surfaces = {
            {name = "dirt", odds = 50, max_height = 3},
        {name = "sand", odds = 25, max_height = 4}
        }
    }
}

for _, e in ipairs(growable) do
    minetest.register_abm({
        nodenames = { e.name },
        interval = 120,
        chance = 2,
        action = function(pos, node, active_object_count, active_object_count_wider)
        -- First check if there is space above to grow
        p_top = {x = pos.x, y = pos.y + 1, z = pos.z}
        n_top = minetest.env:get_node(p_top)

        if n_top.name == "air" then
        -- Calc current height
        cur_height = 1
        p_next = {x = pos.x, y = pos.y - 1, z = pos.z}
        n_next  = minetest.env:get_node(p_next);
        while true do
            if n_next.name ~= node.name then
            break
            end
            cur_height = cur_height + 1
            p_next = {x = p_next.x, y = p_next.y - 1, z = p_next.z}
            n_next = minetest.env:get_node(p_next)
        end

        for _, s in ipairs(e.surfaces) do
            if string.sub(n_next.name, 1, string.len(s.name)) == s.name and (math.random(1, 1000) > (1000 - s.odds)) then
            if cur_height < s.max_height then
                minetest.env:add_node(p_top, {name = node.name})
            end
            end
        end
        end
    end
    })
end
