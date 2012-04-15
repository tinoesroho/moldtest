--[[

Author: Victor Hackeridze hackeridze@gmail.com
VERSION: 0.9.11
LICENSE: GPLv3
TODO: 

]]

PLANTS_GROW_INTERVAL = 120 -- interval in ABMs for plants
PLANTS_GROW_CHANCE = 6 -- chance in ABMs for plants
PLANTS_VISUAL_SCALE = 1.19 -- visualscale for plants



local WHEAT_STATES = {
    '1',
    '2', 
    '3',
    '4',
    '5',
    '6',
    '7',
    --'final',
}
NODES_TO_DELETE_IF_THEY_ABOVE_AIR = {
    "wheat:wheat_1",
    "wheat:wheat_2",
    "wheat:wheat_3",
    "wheat:wheat_4",
    "wheat:wheat_5",
    "wheat:wheat_6",
    "wheat:wheat_7",
    "wheat:wheat_final",
    "wheat:big_grass",
    "watermelon:watermelon_sprout_1",
    "watermelon:watermelon_sprout_2",
    "watermelon:watermelon_sprout_3",
    "watermelon:watermelon_sprout_4",
    "watermelon:watermelon_sprout_5",
    "watermelon:watermelon_sprout_6",
    "watermelon:watermelon_sprout_final",
    "pumpkin:pumpkin_sprout_1",
    "pumpkin:pumpkin_sprout_2",
    "pumpkin:pumpkin_sprout_3",
    "pumpkin:pumpkin_sprout_4",
    "pumpkin:pumpkin_sprout_5",
    "pumpkin:pumpkin_sprout_6",
    "pumpkin:pumpkin_sprout_final",
    "default:jungle_grass",
	"flowers:flower_rose",
	"flowers:flower_dandelion_yellow",
	"flowers:flower_dandelion_white",
	"flowers:flower_tulip",
	"flowers:flower_viola",
    "flowers:flower_cotton",
    "flowers:flower_rose_pot",
	"flowers:flower_dandelion_yellow_pot",
	"flowers:flower_dandelion_white_pot",
	"flowers:flower_tulip_pot",
	"flowers:flower_viola_pot",
    "mushrooms:mushroom_red",
    "mushrooms:mushroom_white",
    "mushrooms:mushroom_brown",
    "default:cactus",
    "default:papyrus",
    "hruschev:corn_sprout_1",
    "hruschev:corn_sprout_2",
    "hruschev:corn_sprout_3",
    "hruschev:corn_sprout_4",
    "hruschev:corn_sprout_5",
    "hruschev:corn_sprout_cob_1",
    "hruschev:corn_sprout_cob_2",
    "hruschev:corn_sprout_cob_3",
    "hruschev:corn_sprout_cob_4",
    "hruschev:corn_sprout_cob_5",
}

local DIRT_BED_TO_GRASS = {
    "zhive_belarus:sprout_1",
    "zhive_belarus:sprout_2",
    "zhive_belarus:sprout_3",
    "zhive_belarus:sprout_4",
    "zhive_belarus:sprout_5",
    "zhive_belarus:sprout_6",
    "wheat:wheat_1",
    "wheat:wheat_2",
    "wheat:wheat_3",
    "wheat:wheat_4",
    "wheat:wheat_5",
    "wheat:wheat_6",
    "wheat:wheat_7",
    "wheat:wheat_final",
    "watermelon:watermelon_sprout_1",
    "watermelon:watermelon_sprout_2",
    "watermelon:watermelon_sprout_3",
    "watermelon:watermelon_sprout_4",
    "watermelon:watermelon_sprout_5",
    "watermelon:watermelon_sprout_6",
    "watermelon:watermelon_sprout_final",
    "pumpkin:pumpkin_sprout_1",
    "pumpkin:pumpkin_sprout_2",
    "pumpkin:pumpkin_sprout_3",
    "pumpkin:pumpkin_sprout_4",
    "pumpkin:pumpkin_sprout_5",
    "pumpkin:pumpkin_sprout_6",
    "pumpkin:pumpkin_sprout_final",
    "hruschev:corn_sprout_1",
    "hruschev:corn_sprout_2",
    "hruschev:corn_sprout_3",
    "hruschev:corn_sprout_4",
    "hruschev:corn_sprout_5",

}

local LIGHT = 5 -- amount of light neded to wheat grow

local check_water = function(pos)
    --[[for x = pos.x - 2, pos.x + 2 do
        for x = pos.z - 2, pos.z + 2 do
            n = minetest.env:get_node_or_nil({x = x, pos.z, z = z})
            if (n == nil) or (n.name == "default:water_source") or (n.name == "default:water_flowing") then
				return true
			end
        end
    end]]
    return true
end
-- ABMs
minetest.register_abm({
    nodenames = {"wheat:wheat_1","wheat:wheat_2","wheat:wheat_3","wheat:wheat_4",
                                           "wheat:wheat_5","wheat:wheat_6","wheat:wheat_7"},
    interval = PLANTS_GROW_INTERVAL/3*2,
    chance = PLANTS_GROW_CHANCE/2,
        action = function(pos, node, _, __)
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            local rnd = math.random(1, 3)
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed") and (rnd == 1) then
                local nname  --= 'wheat:wheat_final' 
                if node.name == "wheat:wheat_1" then 

                        nname = 'wheat:wheat_2'

                elseif node.name == "wheat:wheat_2" then

                        nname = 'wheat:wheat_3'

                elseif  node.name == 'wheat:wheat_3' then

                        nname = 'wheat:wheat_4'

                elseif  node.name == 'wheat:wheat_4' then

                        nname = 'wheat:wheat_5'

                elseif  node.name == 'wheat:wheat_5' then

                        nname = 'wheat:wheat_6'

                elseif  node.name == 'wheat:wheat_6' then

                        nname = 'wheat:wheat_7'
                    
                else nname = 'wheat:wheat_final' end
                p.y = p.y + 1
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, { name = nname })
            end
        end
}) 

minetest.register_abm({
    nodenames = NODES_TO_DELETE_IF_THEY_ABOVE_AIR,
    interval = 3,
    chance = 1,
        action = function(pos, node, _, __)
            local p = {x = pos.x,y = pos.y -1,z = pos.z}
            --p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            if (under_node.name == "air") then
                --p.y = p.y + 1
                minetest.env:remove_node(pos)
                minetest.env:add_node(p, {name = node.name})
            end
        end
})
minetest.register_abm({
    nodenames = "wheat:dirt_bed",
    interval = 40,
    chance = 3,
        action = function(pos, node, _, __)
            local p = {x = pos.x,y = pos.y +1,z = pos.z}
            local above_node = minetest.env:get_node(p)

            for i, plant in ipairs(DIRT_BED_TO_GRASS) do
                if (above_node.name == plant) then return; end             
            end
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, {name = "default:dirt"})
        end
})-- ABMs end

-- Nodes
for i, state in ipairs(WHEAT_STATES) do
    minetest.register_node("wheat:wheat_" .. state, {
	    drawtype = "plantlike",
        tile_images = {"wheat_wheat_" .. state .. ".png"},
	    inventory_image = "wheat_wheat_" .. state .. ".png",
	    paramtype = "light",
	    is_ground_content = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.2),
		drop = {
			items = {
				{
					items = {'wheat:wheat_seeds'},
					rarity = 10,
				},
			},
		},
        wall_mounted = false,
        visual_scale = PLANTS_VISUAL_SCALE,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.4, 1/2},
    	},
    })
	-- Fuel
	minetest.register_craft({
		type = "fuel",
		recipe = "wheat:wheat_" .. state,
		burntime = 2,
	})
end

minetest.register_node("wheat:wheat_final", {
	    drawtype = "plantlike",
        tile_images = {"wheat_wheat_final.png"},
	    inventory_image = "wheat_wheat_final.png",
	    paramtype = "light",
	    is_ground_content = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.25),
		drop = {
			max_items = 1,
			items = {
				{
					items = {'wheat:wheat_seeds 2'},
					rarity = 1.5,
				},
				{
					items = {'wheat:wheat_seeds'},
				}
			}
		},
        wall_mounted = false,
        visual_scale = PLANTS_VISUAL_SCALE,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.4, 1/2},
    	},
}) 

minetest.register_node("wheat:dirt_bed", {
	description = "Dirt bed",
	tile_images = {"wheat_bed.png", "default_dirt.png"},
	inventory_image = minetest.inventorycube("default_dirt.png"),
	is_ground_content = true,
	material = minetest.digprop_dirtlike(1.0),
	drop = {
		max_items = 1,
		items = {
			{
				items = {'default:dirt'},
			}
		}
	},
})

minetest.register_node("wheat:big_grass", {
	    drawtype = "plantlike",
	    paramtype = "facedir_simple",
        tile_images = {"wheat_big_grass.png"},
	    inventory_image = "wheat_big_grass.png",
	    paramtype = "light",
	    is_ground_content = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.1),
		drop = {
			max_items = 1,
			items = {
				{
					items = {'wheat:wheat_seeds'},
					rarity = 10,
				},
			},
		},
        visual_scale = PLANTS_VISUAL_SCALE,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.3, 1/2},
    	},
})-- Nodes end

-- Craftitems
minetest.register_craftitem("wheat:wheat_seeds", {
	description = "Wheat seeds",
    image = "wheat_wheat_seeds.png",
    stack_max = 99,
    usable = true,
    dropcount = 10,
    liquids_pointable = false,
    on_place = minetest.item_place,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="wheat:wheat_1"})
				item:take_item()
			end
		end
		return item
	end,
}) -- Craftitems end

-- Fuel
minetest.register_craft({
    type = "fuel",
    recipe = "wheat:wheat_seeds",
    burntime = 1,
})
	
minetest.register_craft({
    type = "fuel",
    recipe = "wheat:big_grass",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "wheat:wheat_final",
    burntime = 2,
})

print("[Wheat] Loaded!")
