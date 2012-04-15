-- Secret_blocks
-- cuz secret passage was not working
-- Block types
minetest.register_node ("secretblocks:stone", {
	drawtype = draw,
	description = "Stone",
	tile_images = {"default_stone.png"},
	inventory_image = {"default_stone.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:component", {
	drawtype = draw,
	description = "Component",
	tile_images = {"default_grass_footsteps.png"},
	inventory_image = {"default_grass_footsteps.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:cobble", {
	drawtype = draw,
	description = "Cobble",
	tile_images = {"default_cobble.png"},
	inventory_image = {"default_cobble.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:dirt", {
	drawtype = draw,
	description = "Dirt",
	tile_images = {"default_dirt.png"},
	inventory_image = {"default_dirt.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:bookshelf", {
	drawtype = draw,
	description = "Bookshelf",
	tile_images = {"default_bookshelf.png"},
	inventory_image = {"default_bookshelf.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:wood", {
	drawtype = draw,
	description = "Wood",
	tile_images = {"default_wood.png"},
	inventory_image = {"default_wood.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:sand", {
	drawtype = draw,
	description = "Sand",
	tile_images = {"default_sand.png"},
	inventory_image = {"default_sand.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node ("secretblocks:brick", {
	drawtype = draw,
	description = "Brick",
	tile_images = {"default_brick.png"},
	inventory_image = {"default_brick.png"},
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	material = minetest.digprop_constanttime(1.0),
	
   })
minetest.register_node("secretblocks:dirt_with_grass", {
	description = "Dirt with grass",
	tile_images = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	walkable = false,
	material = minetest.digprop_dirtlike(1.0),
	drop = 'default:dirt',
})
-- Crafting
minetest.register_craft({
    output = '"secretblocks:component"',
    recipe = {
        {'',"default:coal_lump",''},
        {'',"default:glass",''},
    },
})
minetest.register_craft({
    output = '"secretblocks:dirt"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:dirt",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:wood"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:wood",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:stone"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:stone",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:cobble"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:cobble",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:bookshelf"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:bookshelf",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:sand"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:sand",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:brick"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:brick",'',''},
    },
})

minetest.register_craft({
    output = '"secretblocks:dirt_with_grass"',
    recipe = {
        {"secretblocks:component",'',''},
        {"default:dirt_with_grass",'',''},
    },
})
