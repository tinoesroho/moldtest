-- Secret_blocks
-- cuz secret passage was not working
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