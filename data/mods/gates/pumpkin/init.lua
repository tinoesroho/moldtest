--[[

Author: Victor Hackeridze hackeridze@gmail.com
VERSION: 0.4
LICENSE: GPLv3
TODO:

]]
local PUMPKIN_SPROUT_STATES = {
    '1',
    '2', 
    '3',
    '4',
    '5',
    '6',
    'final',
	'stale',       -- типа засох
}

local LIGHT = 5 -- amount of light neded to pumpkin grow

local function register_falling_pumpkin(nodename)
	default.falling_node_names[nodename] = true
	-- Override naming conventions for stuff like :default:falling_default:sand
	minetest.register_entity(":default:falling_"..nodename, {
		-- Static definition
		physical = true,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "cube",
		textures = {"pumpkin_pumpkin_top.png","pumpkin_pumpkin_top.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png"},
		-- State
		-- Methods
		on_step = function(self, dtime)
			-- Set gravity
			self.object:setacceleration({x=0, y=-10, z=0})
			-- Turn to actual sand when collides to ground or just move
			local pos = self.object:getpos()
			local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z} -- Position of bottom center point
			local bcn = minetest.env:get_node(bcp)

			if bcn.name ~= "air" then
				-- Turn to a sand node
				minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'pumpkin:pumpkin_seeds 1')
				minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'pumpkin:pumpkin_seeds 1')
				minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'pumpkin:pumpkin_seeds 1')
				self.object:remove()
			else
				-- Do nothing
			end
		end
	})
end

-- ABMs
minetest.register_abm({
    nodenames = {"pumpkin:pumpkin_sprout_1","pumpkin:pumpkin_sprout_2",
											"pumpkin:pumpkin_sprout_3","pumpkin:pumpkin_sprout_4",
                                        	"pumpkin:pumpkin_sprout_5","pumpkin:pumpkin_sprout_6"},
    interval = PLANTS_GROW_INTERVAL,
    chance = PLANTS_GROW_CHANCE,
        action = function(pos, node, _, __)
if (math.random(1,3) > 1) then return 0; end
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed")  then
                local nname  --= 'wheat:wheat_final' 
                if node.name == "pumpkin:pumpkin_sprout_1" then 
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_2'
                    --end
                elseif node.name == "pumpkin:pumpkin_sprout_2" then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_3'
                    --end
                elseif  node.name == 'pumpkin:pumpkin_sprout_3' then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_4'
                    --end
                elseif  node.name == 'pumpkin:pumpkin_sprout_4' then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_5'
                    --end
                elseif  node.name == 'pumpkin:pumpkin_sprout_5' then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_6'
                    --end
                else nname = 'pumpkin:pumpkin_sprout_final' end
                p.y = p.y + 1
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, { name = nname })
            elseif (under_node.name == "air") then
                p.y = p.y + 1
                minetest.env:remove_node(pos)
            end
        end
})

local WM_POS = {{x=1,z=1}, {x=-1,z=-1}, {x=1,z=-1}, {x=-1,z=1}}
local WM_POS_COL = 4

minetest.register_abm({ --WARNING!!! DO NOT TRY UNDERSTAND HOW IT WORKS!!!
    nodenames = {"pumpkin:pumpkin_sprout_final"},
    interval = (PLANTS_GROW_INTERVAL*3)/2,
    chance = PLANTS_GROW_CHANCE,
        action = function(pos, node, _, __)
if (math.random(1,4) > 1) then return 0; end
if (node.param2 > 3) then return; end
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
			p.y = p.y + 1
			        
				if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed") and (node.name == "pumpkin:pumpkin_sprout_final")  then
				for i=1,math.random(1,4) do
						val = WM_POS[math.random(1,WM_POS_COL)]
						nx1 = minetest.env:get_node({x=pos.x+val.x,y=pos.y,z=pos.z+val.z})
						if (nx1.name == "air")  then
							minetest.env:add_node({x=pos.x+val.x,y=pos.y,z=pos.z+val.z}, { name = 'pumpkin:pumpkin'})
							nodeupdate_single({x=pos.x+val.x,y=pos.y,z=pos.z+val.z})
							node.param2 = node.param2 + 1
						end
				end
				if math.random(1,3) == 1 then
					replace_node(pos, "pumpkin:pumpkin_sprout_stale")
				end
            end
        end
}) -- ABMs end

-- Nodes
for i, state in ipairs(PUMPKIN_SPROUT_STATES) do
    minetest.register_node("pumpkin:pumpkin_sprout_" .. state, {
	drawtype = "plantlike",
	tile_images = {"watermelon_watermelon_sprout_" .. state .. ".png"},
	inventory_image = "watermelon_watermelon_sprout_" .. state .. ".png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
    visual_scale = 1.19,
	drop = {
		max_items = 1,
		items = {
			{
				items = {'pumpkin:pumpkin_seeds'},
				rarity = 10,
			},
		}
	},
	wall_mounted = false,
    visual_scale = PLANTS_VISUAL_SCALE,
    param2 = 0,
    })
	
	--fuel
	minetest.register_craft({
		type = "fuel",
		recipe = "pumpkin:pumpkin_sprout_" .. state,
		burntime = 2,
	})	
end

minetest.register_node("pumpkin:pumpkin", {
	description = "Pumpkin",
	tile_images = {"pumpkin_pumpkin_top.png","pumpkin_pumpkin_top.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png"},
	inventory_image = minetest.inventorycube("pumpkin_pumpkin_top.png","pumpkin_pumpkin.png", "pumpkin_pumpkin.png"),
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	material = minetest.digprop_constanttime(0.6),
}) 

--=======================
register_falling_pumpkin("pumpkin:pumpkin")
--=======================

minetest.register_node("pumpkin:pumpkin_light", {
	description = "Pumpkin light",
	tile_images = {"pumpkin_pumpkin_top.png","pumpkin_pumpkin_top.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin_light_front.png"},
	inventory_image = minetest.inventorycube("pumpkin_pumpkin_top.png","pumpkin_pumpkin_light_front.png", "pumpkin_pumpkin.png"),
	paramtype = "facedir_simple",
	walkable = true,
	sunlight_propagates = true,
	wall_mounted = false,
	light_source = 17,
	material = minetest.digprop_constanttime(0.6),
})-- Nodes end

-- Craftitems
minetest.register_craftitem("pumpkin:pumpkin_seeds", {
	description = "Pumpkin seeds",
    inventory_image = "pumpkin_pumpkin_seeds.png",
    stack_max = 99,
    usable = true,
    liquids_pointable = false,
    on_place = minetest.item_place,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="pumpkin:pumpkin_sprout_1"})
				item:take_item()
			end
		end
		return item
	end,
}) -- Craftitems end

-- Crafts
minetest.register_craft({
    output = 'pumpkin:pumpkin_light 1',
    recipe = {
        {'pumpkin:pumpkin 1'},
        {'default:torch 1'},
    },
}) 

minetest.register_craft({
    output = 'pumpkin:pumpkin_seeds 3',
    recipe = {
        {'pumpkin:pumpkin 1'},
    },
}) -- Crafts end

--fuel
minetest.register_craft({
	type = "fuel",
	recipe = "pumpkin:pumpkin_seeds",
	burntime = 1,
})


local pumpkins_gen = function( minp, maxp )
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
						if math.random(1,5) > 1 then return true
						else
							local n = minetest.env:get_node( pos )
							if n.name == "default:dirt_with_grass" then
								print("Pumpkin generated above " .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z)
								minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z}, { name = "pumpkin:pumpkin" } )
							end
						end
end


minetest.register_on_generated( pumpkins_gen)


print("[Pumpkin] Loaded!")
