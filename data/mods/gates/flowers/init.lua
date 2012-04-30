--[[
-- Flowers mod by ironzorg
--]]


local DEBUG = 0

local FLOWERS = {
	"rose",
	"dandelion_yellow",
	"dandelion_white",
	"tulip",
	"viola",
    "cotton",
}

local FLOWERS_VISUAL_SCALE = 1.1
local MAX_RATIO = 10000*50
local GROWING_DELAY = 3600*6

-- Local Functions

local formatname = function(s)
	s = s:gsub("^%s*(.-)%s*$", "%1")   -- some kind of magic!!!!
	s = s:gsub("_", " ")
	return s:gsub("^%l", string.upper)
end

local dbg = function(s)
	if DEBUG == 1 then
		print('[FLOWERS] ' .. s)
	end
end

local table_contains = function(t, v)
	for _, i in ipairs(t) do
		if (i == v) then
			return true
		end
	end

	return false
end

local is_node_in_cube = function(nodenames, node_pos, radius)
	for x = node_pos.x - radius, node_pos.x + radius do
		for y = node_pos.y - radius, node_pos.y + radius do
			for z = node_pos.z - radius, node_pos.z + radius do
				n = minetest.env:get_node_or_nil({x = x, y = y, z = z})
				if (n == nil)
					or (n.name == 'ignore')
					or (table_contains(nodenames, n.name) == true) then
					return true
				end
			end
		end
	end

	return false
end

local grow_blocks_on_surfaces = function(growdelay, grownames, surfaces)
	for _, surface in ipairs(surfaces) do
		minetest.register_abm({
			nodenames = { surface.name },
			interval = growdelay,
			chance = 50,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local p_top = {
					x = pos.x,
					y = pos.y + 1,
					z = pos.z
				}
				local n_top = minetest.env:get_node(p_top)
				local rnd = math.random(1, MAX_RATIO)

				if (MAX_RATIO - surface.chance < rnd) then
					local flower_in_range = is_node_in_cube(grownames, p_top, surface.spacing)
					if (n_top.name == "air") and (flower_in_range == false) then
						local nnode = grownames[math.random(1, #grownames)]
						minetest.env:add_node(p_top, { name = nnode })
					end
				end
			end
		})
	end
end

-- Nodes
for _, color in ipairs(FLOWERS) do
	local fname = 'flower_' .. color

	minetest.register_node('flowers:' .. fname, {
		description = formatname(color),
		drawtype = 'plantlike',
		visual_scale = FLOWERS_VISUAL_SCALE,
		tile_images = { fname .. '.png' },
		inventory_image = fname .. '.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		material = minetest.digprop_constanttime(0.0),
        selection_box = {
    		type = "fixed",
    		fixed = {-1/5-0.1, -1/2, -1/5-0.1, 1/5+0.1, 1/5+0.1, 1/5+0.1},
    	},
	})
			
-- fuel recipes 
	minetest.register_craft({
		type = "fuel",
		recipe = 'flowers:' .. fname,
		burntime = 1,
	})
end

minetest.register_node('flowers:flower_waterlily', {
	description = "Water lily",
	drawtype = 'raillike',
	tile_images = { 'flower_waterlily.png', },
	inventory_image = 'flower_waterlily.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(0.0),
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.52, 1/2},
    	},
})

-- Items
minetest.register_craftitem('flowers:flower_pot', {
	description = "Flower pot",
	drawtype = 'plantlike',
	image = 'flower_pot.png',
	stack_max = 1,
	visual_scale = FLOWERS_VISUAL_SCALE,
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	material = minetest.digprop_constanttime(0.5),
        selection_box = {
    		type = "fixed",
    		fixed = {-1/5-0.1, -1/2, -1/5-0.1, 1/5+0.1, 1/5+0.1, 1/5+0.1},
    	},
})

for _, color in ipairs(FLOWERS) do
	local fname = 'flower_' .. color
	local pname = fname .. '_pot'

	minetest.register_craftitem('flowers:' .. pname, {
		description = color .. " pot",
		drawtype = 'plantlike',
		image = pname .. '.png',
		stack_max = 1,
		visual_scale = FLOWERS_VISUAL_SCALE*1.2,
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		material = minetest.digprop_constanttime(1.0),
        selection_box = {
    		    type = "fixed",
    		    fixed = {-1/5-0.1, -1/2, -1/5-0.1, 1/5+0.1, 1/5+0.1, 1/5+0.1},
    	    },
    })
end

minetest.register_craftitem('flowers:cotton', {
	description = "Cotton",
	image = 'cotton.png',
    furnace_burntime = 15;
    on_place = minetest.item_place,
})

-- Crafts
minetest.register_craft({
	output = 'flowers:flower_pot 9', -- I think that 3 clay bricks for one pot is... not good.
	recipe = {
		{'default:clay_brick 1', '', 'default:clay_brick 1'},
		{'', 'default:clay_brick 1', ''},
	}
})

for _, color in ipairs(FLOWERS) do
	local fname = 'flowers:flower_' .. color
	local pname = fname .. '_pot'

	minetest.register_craft({
		output = '' .. pname .. ' 1',
		recipe = {
			{'' .. fname .. ' 1'},
			{'flowers:flower_pot 1'},
		}
	})
end

minetest.register_craft({
	output = 'flowers:cotton 1',
	recipe = {
		{'flowers:flower_cotton 1'},
	}
})


-- Make it grow !
grow_blocks_on_surfaces(GROWING_DELAY * 2, {
	"flowers:flower_rose",
	"flowers:flower_dandelion_white",
	"flowers:flower_viola",
	}, {
	{name = "dirt_with_grass", chance = 24, spacing = 2},
})

grow_blocks_on_surfaces(GROWING_DELAY, {
	"flowers:flower_dandelion_yellow",
	"flowers:flower_tulip",
	}, {
	{name = "dirt_with_grass", chance = 14, spacing = 2},
})

grow_blocks_on_surfaces(GROWING_DELAY * 3, {
	"flowers:flower_waterlily",
	}, {
	{name = "water_source", chance = 14, spacing = 2},
})

grow_blocks_on_surfaces(GROWING_DELAY, {
	"flowers:flower_cotton",
	}, {
    {name = "dirt_with_grass", chance = 14, spacing = 2},
})

grow_blocks_on_surfaces(GROWING_DELAY*5, {
    "wheat:big_grass",
	}, {
    {name = "dirt_with_grass", chance = 500, spacing = 0},
})
--[[
grow_blocks_on_surfaces(GROWING_DELAY*40, {
    "pumpkin:pumpkin",
	}, {
    {name = "dirt_with_grass", chance = 1, spacing = 0},
})

grow_blocks_on_surfaces(GROWING_DELAY*40, {
    "watermelon:watermelon",
	}, {
    {name = "dirt_with_grass", chance = 1, spacing = 0},
})]]

print("[Flowers] Loaded!")
