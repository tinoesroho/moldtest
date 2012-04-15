-- Local constants
-- This _has_ to be set to 1
local GATE_OPENED = 2
-- This has to be != from GATE_OPENED and is coded on 4 bits
local GATE_CLOSED = 1

-- Local Functions
local on_gate_punched = function(pos, node, puncher)
    if (node.name ~= 'gates:gate_closed')
        and (node.name ~= 'gates:gate_opened') then
        return
    end

    local state = node.param2

    local toggle_gate = function(pos, state)
        local nodename = ""
        local param2 = ""
        -- Switch the gate state when hit
        if state == GATE_OPENED then
            nodename = 'gates:gate_closed'
            param2 = GATE_CLOSED
        elseif state == GATE_CLOSED then
            nodename = 'gates:gate_opened'
            param2 = GATE_OPENED
        else
            print('Uninitialized node: ' .. state)
            return
        end

        minetest.env:add_node(pos, {
            name = nodename,
            param2 = param2,
        })
    end

    toggle_gate(pos, state)

    --handle gates above this one
    local lpos = {x=pos.x, y=pos.y, z=pos.z}
    while true do
        lpos.y = lpos.y+1
        local lnode = minetest.env:get_node(lpos)
        if (lnode.name ~= "gates:gate_closed" and lnode.name ~= "gates:gate_opened") then
            break
        end
        toggle_gate(lpos, state)
    end

    --handle gates below this one
    local lpos = {x=pos.x, y=pos.y, z=pos.z}
    while true do
        lpos.y = lpos.y-1
        local lnode = minetest.env:get_node(lpos)
        if (lnode.name ~= "gates:gate_closed" and lnode.name ~= "gates:gate_opened") then
            break
        end
        toggle_gate(lpos,state)
    end
end

local on_gate_placed = function(pos, node, placer)
    if node.name ~= 'gates:gate_closed' then
        return
    end

    minetest.env:add_node(pos, {
        name = node.name,
        param2 = GATE_CLOSED,
    })
end

-- Nodes
minetest.register_node('gates:gate_opened', {
    drawtype = 'plantlike',
    visual_scale = 1.5,
    tile_images = {'gate_open.png'},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = false,
    material = minetest.digprop_constanttime(1.0),
    drop = "gates:gate_closed",
})

minetest.register_node('gates:gate_closed', {
    description = "Gate",
    tile_images = {'gate_top.png','gate_top.png','gate.png'},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    material = minetest.digprop_constanttime(1.0),
})

-- Crafts
minetest.register_craft({
    output = '"gates:gate_closed" 2',
    recipe = {
        {"default:stick", "default:wood", "default:stick"},
        {"default:stick", "default:wood", "default:stick"},
    },
})

-- Change the gate state
minetest.register_on_punchnode(on_gate_punched)
-- Reset param2 for open gates
minetest.register_on_placenode(on_gate_placed)

-- Mesecon Stuff:
--mesecon:register_on_signal_on(on_gate_punched)
--mesecon:register_on_signal_off(on_gate_punched)

print("[Gates] Loaded!")
