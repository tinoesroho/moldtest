minetest.register_craft({
    output = 'default:steel_ingot 9',
    recipe = {
        {'default:steelblock'},
    }
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'default:jungletree'},
	}
})

minetest.register_craft({
	output = 'moarcraft:stone_brick 4',
	recipe = {
		{'default:stone','default:stone'},
		{'default:stone','default:stone'},
	}
})

minetest.register_node("moarcraft:stone_brick", {
	description = "Stone brick",
	tile_images = {"default_stone.png^moarcraft_stone_brick.png"},
	inventory_image = minetest.inventorycube("default_stone.png^moarcraft_stone_brick.png"),
	paramtype = "mineral",
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.7),
	legacy_mineral = true,
	drop = 'moarcraft:stone_brick 1',
})


minetest.register_craft({
    type = "cooking",
    output = "moarcraft:ash",
    recipe = "default:stick",
    cooktime = 10,
})

minetest.register_craftitem("moarcraft:ash", {
	description = "Ash",
	image = "moarcraft_ash.png",
	on_place = minetest.item_place,
})

print("[Moarcraft] Loaded!")
