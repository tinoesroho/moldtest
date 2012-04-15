--[[
****
More Ores
by Calinou, thanks to MarkTraceur for add_tool function. Much shorter code.
Version 12.01.30
****
--]]

-- Nemo08:
--  How it works????!!!!
--  on_place_on_ground = minetest.craftitem_place_item, -> on_place_on_ground, craftitem_place_item removed!!!
--  node, craft not needed!!!!
--  How??
--  But, if it works i add sulfur, nitrate, limestone in same style. =/


-- Blocks

minetest.register_node( "moreores:mineral_gold", {
	description = "Gold Ore",
	tile_images = { "default_stone.png^moreores_mineral_gold.png" },
	inventory_inventory_image = minetest.inventorycube( "default_stone.png^moreores_mineral_gold.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
	drop = 'craft "moreores:gold_lump" 1',
})

minetest.register_node( "moreores:gold_block", {
	description = "Gold Block",
	tile_images = { "moreores_gold_block.png" },
	inventory_inventory_image = minetest.inventorycube( "moreores_gold_block.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
})

minetest.register_node( "moreores:mineral_silver", {
	description = "Silver Ore",
	tile_images = { "default_stone.png^moreores_mineral_silver.png" },
	inventory_inventory_image = minetest.inventorycube( "default_stone.png^moreores_mineral_silver.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
	drop = 'craft "moreores:silver_lump" 1',
})

minetest.register_node( "moreores:silver_block", {
	description = "Silver Ore",
	tile_images = { "moreores_silver_block.png" },
	inventory_inventory_image = minetest.inventorycube( "moreores_silver_block.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
})

minetest.register_node( "moreores:mineral_copper", {
	description = "Copper Ore",
	tile_images = { "default_stone.png^moreores_mineral_copper.png" },
	inventory_inventory_image = minetest.inventorycube( "default_stone.png^moreores_mineral_copper.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
	drop = 'craft "moreores:copper_lump" 1',
})

minetest.register_node( "moreores:mineral_tin", {
	description = "Tin Ore",
	tile_images = { "default_stone.png^moreores_mineral_tin.png" },
	inventory_inventory_image = minetest.inventorycube( "default_stone.png^moreores_mineral_tin.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
	drop = 'craft "moreores:tin_lump" 1',
})

minetest.register_node( "moreores:bronze_block", {
	description = "Bronze Block",
	tile_images = { "moreores_bronze_block.png" },
	inventory_inventory_image = minetest.inventorycube( "moreores_bronze_block.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
})

	------------------------------------
minetest.register_node( "moreores:mineral_sulfur", {
	description = "Sulfur",
	tile_images = { "default_stone.png^moreores_mineral_sulfur.png" },
	inventory_image = minetest.inventorycube( "default_stone.png^moreores_mineral_sulfur.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.4),
	drop = 'craft "moreores:sulfur" 3',
})

minetest.register_node( "moreores:limestone", {
	description = "Limestone",
	tile_images = { "moreores_limestone.png" },
	inventory_image = minetest.inventorycube( "moreores_limestone.png" ),
	is_ground_content = true,
	material = minetest.digprop_dirtlike(2.3),
})

minetest.register_node( "moreores:mineral_nitrate", {
	description = "Nitrate mineral",
	tile_images = { "default_stone.png^moreores_mineral_nitrate.png" },
	inventory_image = minetest.inventorycube( "default_stone.png^moreores_mineral_nitrate.png" ),
	is_ground_content = true,
	material = minetest.digprop_stonelike(0.7),
	drop = 'craft "moreores:nitrate" 3',
})

-- Items

minetest.register_craftitem( "moreores:gold_lump", {
	description = "Lump of gold",
	inventory_image = "moreores_gold_lump.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:gold_ingot", {
	description = "Gold ingot",
	inventory_image = "moreores_gold_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:silver_lump", {
	description = "Lump of silver",
	inventory_image = "moreores_silver_lump.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:silver_ingot", {
	description = "Silver ingot",
	inventory_image = "moreores_silver_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:copper_lump", {
	description = "Lump of copper",
	inventory_image = "moreores_copper_lump.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:copper_ingot", {
	description = "Copper ingot",
	inventory_image = "moreores_copper_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:tin_lump", {
	description = "Lump of tin",
	inventory_image = "moreores_tin_lump.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:tin_ingot", {
	description = "Tin ingot",
	inventory_image = "moreores_tin_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:bronze_ingot", {
	description = "Bronze ingot",
	inventory_image = "moreores_bronze_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "moreores:sulfur", {
	description = "Sulfur",
	image = "moreores_sulfur.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "moreores:nitrate", {
	description = "Nitrate",
	image = "moreores_nitrate.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "moreores:calcium_oxide", {
	description = "Calcium oxide",
	image = "moreores_calcium_oxide.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

-- Tools (function is in add_tool)

register_tool_type("moreores", "Bronze", "bronze", 'craft "moreores:bronze_ingot"', 1.2, 200, {shovel_durability = 40})
register_tool_type("moreores", "Silver", "silver", 'craft "moreores:silver_ingot"', 1.1, 240, {shovel_durability = 40})
register_tool_type("moreores", "Golden","gold", 'craft "moreores:gold_ingot"', 0.6, 180, {shovel_durability = 40})

-- Crafting

minetest.register_craft( {
	output = 'craft "moreores:bronze_ingot"',
	recipe = {
		{ 'craft "moreores:tin_ingot"'},
		{ 'craft "moreores:copper_ingot"'},
	}
})

minetest.register_craft( {
	output = 'craft "moreores:bronze_ingot"',
	recipe = {
		{ 'craft "moreores:copper_ingot"'},
		{ 'craft "moreores:tin_ingot"'},
	}
})

minetest.register_craft( {
	output = 'node "moreores:gold_block" 1',
	recipe = {
		{ 'craft "moreores:gold_ingot"', 'craft "moreores:gold_ingot"', 'craft "moreores:gold_ingot"' },
		{ 'craft "moreores:gold_ingot"', 'craft "moreores:gold_ingot"', 'craft "moreores:gold_ingot"' },
		{ 'craft "moreores:gold_ingot"', 'craft "moreores:gold_ingot"', 'craft "moreores:gold_ingot"' },
	}
})

minetest.register_craft( {
	output = 'craft "moreores:gold_ingot" 9',
	recipe = {
		{ 'node "moreores:gold_block"' },
	}
})

minetest.register_craft( {
	output = 'node "moreores:silver_block" 1',
	recipe = {
		{ 'craft "moreores:silver_ingot"', 'craft "moreores:silver_ingot"', 'craft "moreores:silver_ingot"' },
		{ 'craft "moreores:silver_ingot"', 'craft "moreores:silver_ingot"', 'craft "moreores:silver_ingot"' },
		{ 'craft "moreores:silver_ingot"', 'craft "moreores:silver_ingot"', 'craft "moreores:silver_ingot"' },
	}
})

minetest.register_craft( {
	output = 'craft "moreores:silver_ingot" 9',
	recipe = {
		{ 'node "moreores:silver_block"' },
	}
})

minetest.register_craft( {
	output = 'node "moreores:bronze_block" 1',
	recipe = {
		{ 'craft "moreores:bronze_ingot"', 'craft "moreores:bronze_ingot"', 'craft "moreores:bronze_ingot"' },
		{ 'craft "moreores:bronze_ingot"', 'craft "moreores:bronze_ingot"', 'craft "moreores:bronze_ingot"' },
		{ 'craft "moreores:bronze_ingot"', 'craft "moreores:bronze_ingot"', 'craft "moreores:bronze_ingot"' },
	}
})

minetest.register_craft( {
	output = 'craft "moreores:bronze_ingot" 9',
	recipe = {
		{ 'node "moreores:bronze_block"' },
	}
})

-- Smelting

minetest.register_craft({
    type = "cooking",
    output = "moreores:gold_ingot",
    recipe = "moreores:gold_lump",
})

minetest.register_craft({
    type = "cooking",
    output = "moreores:silver_ingot",
    recipe = "moreores:silver_lump",
})

minetest.register_craft({
    type = "cooking",
    output = "moreores:tin_ingot",
    recipe = "moreores:tin_lump",
})

minetest.register_craft({
    type = "cooking",
    output = "moreores:copper_ingot",
    recipe = "moreores:copper_lump",
})

	
minetest.register_craft({
    type = "cooking",
    output = "moreores:calcium_oxide 4",
    recipe = "moreores:limestone",
})

-- Generation

local copperore = {
	"moreores:mineral_copper"
}

local copper_gen = function( minp, maxp )
	for c, coppermineral in ipairs(copperore) do
		local amount = math.random( 0, 10 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.2 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = coppermineral } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( copper_gen )

local tinore = {
	"moreores:mineral_tin"
}

local tin_gen = function( minp, maxp )
	for c, tinmineral in ipairs(tinore) do
		local amount = math.random( 0, 8 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.2 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = tinmineral } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( tin_gen )

local silverore = {
	"moreores:mineral_silver"
}

local silver_gen = function( minp, maxp )
	for c, silvermineral in ipairs(silverore) do
		local amount = math.random( 0, 4 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.2 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = silvermineral } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( silver_gen )

local goldore = {
	"moreores:mineral_gold"
}

local gold_gen = function( minp, maxp )
	for c, goldmineral in ipairs(goldore) do
		local amount = math.random( 0, 1 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.2 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = goldmineral } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( gold_gen )

local sulfurore = {
	"moreores:mineral_sulfur"
}

local sulfur_gen = function( minp, maxp )
    if maxp.y > -10 then return; end
    if math.random(1,4) > 1 then return; end
	for c, sulfurmineral in ipairs(sulfurore) do
		local amount = math.random( 0, 3 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 2 do
					for k = -1, 1 do
						if math.random() > 0.5 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = sulfurmineral } )
							end
						end
					end
				end
			end
		end
	end
end


minetest.register_on_generated( sulfur_gen )

local nitrateore = {
	"moreores:mineral_nitrate"
}

local nitrate_gen = function( minp, maxp )
    if maxp.y > -10 then return; end
    if math.random(1,4) > 1 then return; end
	for c, nitratemineral in ipairs(nitrateore) do
		local amount = math.random( 0, 4 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -2, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.5 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = nitratemineral } )
							end
						end
					end
				end
			end
		end
	end
end


minetest.register_on_generated( nitrate_gen )

local limestoneore = {
	"moreores:limestone"
}

local limestone_gen = function( minp, maxp )
    if math.random(1,2) > 1 then return; end
	for c, limestonemineral in ipairs(limestoneore) do
		local amount = math.random( 0, 1 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -2, 1 do
				for j = -1, 2 do
					for k = -2, 2 do
						if math.random() > 0.5 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = limestonemineral } )
							end
						end
					end
				end
			end
		end
	end
end


minetest.register_on_generated( limestone_gen )
print("[MoreOres0] Loaded!")