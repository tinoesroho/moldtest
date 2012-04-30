local FLOWER_COLORS = {  -- same as FLOWERS without cotton %(
	red = "rose",
	yellow = "dandelion_yellow",
	white = "dandelion_white",
	orange = "tulip",
	violet = "viola",
}

local formatname = function(s)
	s = s:gsub("^%s*(.-)%s*$", "%1")   -- some kind of magic!!!!
	s = s:gsub("_", " ")
	return s:gsub("^%l", string.upper)
end

local add_to_inventory = function(player,items,myitemadd)
	local myitemstack = ItemStack(myitemadd)
	local leftover = player:get_inventory():add_item("main", myitemstack)
	if leftover:is_empty() then
		items:take_item()
	else
		minetest.chat_send_player(player:get_player_name(), 'Not enough space in inventory!')
	end
	return items
end
	
minetest.register_craft({
	output = 'home_mod:can 1',
	recipe = {
		{'steel_ingot', '', 'steel_ingot'},
		{'steel_ingot', '', 'steel_ingot'},
		{'steel_ingot', 'steel_ingot', 'steel_ingot'}
	}
})
minetest.register_craft({
	output = 'node "home_mod:white_wallpaper" 1',
	recipe = {
		{'craft "default:paper"'},
	}
})

for key,value in pairs(FLOWER_COLORS) do
	-- colour petals
	minetest.register_craft({
		output = 'home_mod:' .. value .. '_petal 6',
		recipe = {
			{'flowers:flower_' .. value},
		}
	})	
	minetest.register_craftitem("home_mod:" .. value .. "_petal", {
	description = formatname(value .. " petal"),
		inventory_image = value .. "_petal.png",
		on_place = minetest.item_place,
	})
	-- colour wallpapers
	minetest.register_node("home_mod:" .. key .. "_wallpaper", {
		description = formatname(key .. " wallpaper"),
		drawtype = "signlike",
		tile_images = {key .. "_wallpaper.png"},
		inventory_image = key .. "_wallpaper.png",
		wield_image = key .. "_wallpaper.png",
		paramtype = "light",
		paramtype2 = 'wallmounted',
		is_ground_content = true,
		sunlight_propagates = true,
		walkable = false,
		drop = 'home_mod:' .. key .. '_wallpaper 1',
		material = minetest.digprop_constanttime(0.2),
		selection_box = {
			type = "wallmounted",
			--wall_top = = <default>
			--wall_bottom = = <default>
			--wall_side = = <default>
		},
	})
	-- colour cobbles
	minetest.register_node("home_mod:" .. key .. "_cobble", {
		description = formatname(key .. " cobble"),
		tile_images = {key .. "_cobble.png"},
		is_ground_content = true,
		cookresult_itemstring = 'home_mod:' .. key .. '_stone 1',
		material = minetest.digprop_stonelike(0.9),
	})	
	minetest.register_craft({
		type = "cooking",
		output = 'home_mod:' .. key .. '_stone',
		recipe = "home_mod:" .. key .. "_cobble",
	})
	-- colour stones
	minetest.register_node("home_mod:"  .. key .. "_stone", {
		description = formatname(key .. " stone"),
		tile_images = {key .. "_stone.png"},
		is_ground_content = true,
		legacy_mineral = true,
		material = minetest.digprop_stonelike(1.0),
		drop = "home_mod:" .. key .. '_cobble',
	})
	-- colour bricks
	if key ~= "red" then
		minetest.register_node("home_mod:" .. key .."_brick", {
			description = formatname(key .. " brick"),
			tile_images = {key .. "_brick.png"},
			is_ground_content = true,
			material = minetest.digprop_stonelike(1.0),
			drop = 'default:clay_brick 4',
		})
	end
	-- colour fences
	minetest.register_node("home_mod:" .. key .."_fence_wood", {
		description = formatname(key .. " fence"),
		drawtype = "fencelike",
		tile_images = {key .. "_wood.png"},
		inventory_image = key .. "_fence.png",
		paramtype = "light",
		is_ground_content = true,
		selection_box = {
			type = "fixed",
			fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
		},
		material = minetest.digprop_woodlike(0.75),
	})
			
	minetest.register_craft({
		type = "fuel",
		recipe = "home_mod:" .. key .."_fence_wood",
		burntime = 15,
	})
	-- colour trees
	minetest.register_node("home_mod:" .. key .."_tree", {
		description = formatname(key .. " tree"),
		tile_images = {key .."_tree_top.png", key .. "_tree_top.png", key .. "_tree.png"},
		inventory_image = minetest.inventorycube(key .. "_tree_top.png", key .. "_tree.png", key .. "_tree.png"),
		is_ground_content = true,
		material = minetest.digprop_woodlike(1.0),
		cookresult_itemstring = 'default:coal_lump 1',
	})
		
	minetest.register_craft({
		type = "fuel",
		recipe = "home_mod:" .. key .."_tree",
		burntime = 30,
	})
		
	minetest.register_craft({
		output = "home_mod:" .. key .."_wood 4",
		recipe = {
			{"home_mod:" .. key .."_tree"},
		}
	})
		
	-- colour woods
	minetest.register_node("home_mod:" .. key .."_wood", {
		description = formatname(key .. " wood"),
		tile_images = {key .. "_wood.png"},
		is_ground_content = true,
		material = minetest.digprop_woodlike(0.75),
	})
	
	minetest.register_craft({
		type = "fuel",
		recipe = "home_mod:" .. key .."_wood",
		burntime = 7,
	})
		
	-- colour steel blocks
	if key ~= "white" then
		minetest.register_node("home_mod:" .. key .."_steelblock", {
			description = formatname(key .. " steel block"),
			tile_images = {key .. "_steel_block.png"},
			is_ground_content = true,
			material = minetest.digprop_stonelike(5.0),
		})
	end
	-- colour cans
	minetest.register_craft({
		output = 'home_mod:' .. value .. '_can 1',
		recipe = {
			{'home_mod:' .. value .. '_petal'},
			{'home_mod:can'},
		}
	})
	
	minetest.register_craftitem("home_mod:" .. value .. "_can", {
		description = formatname(value .." can"),
		inventory_image = value .. "_can.png",
		on_place = minetest.item_place,
		on_use = function(item, player, pointed_thing)
			if pointed_thing.type == "node" then
				n = minetest.env:get_node(pointed_thing.under)
				if string.match(n.name, "home_mod:%a-_wallpaper") ~= nil then
					minetest.env:remove_node(pointed_thing)
					minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .."_wallpaper", param2=n.param2})
					return add_to_inventory(player,item,'home_mod:can 1')
				elseif string.match(n.name, "%a-wood") ~= nil then
					if string.match(n.name, "%a-fence_wood") ~= nil then
						minetest.env:remove_node(pointed_thing)
						minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_fence_wood"})
					return add_to_inventory(player,item,'home_mod:can 1')
					else
						minetest.env:remove_node(pointed_thing)
						minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_wood"})
					return add_to_inventory(player,item,'home_mod:can 1')
					end
				elseif string.match(n.name, "%a-cobble") ~= nil then
					minetest.env:remove_node(pointed_thing)
					minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_cobble"})
					return add_to_inventory(player,item,'home_mod:can 1')
				elseif string.match(n.name, "%a-steelblock") ~= nil then
					if value ~= "dandelion_white" then
						minetest.env:remove_node(pointed_thing)
						minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_steelblock"})
						return add_to_inventory(player,item,'home_mod:can 1')
					end
				elseif string.match(n.name, "%a-stone") ~= nil then
					minetest.env:remove_node(pointed_thing)
					minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_stone"})
					return add_to_inventory(player,item,'home_mod:can 1')
				elseif string.match(n.name, "%a-tree") ~= nil then
					minetest.env:remove_node(pointed_thing)
					minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_tree"})
					return add_to_inventory(player,item,'home_mod:can 1')
				elseif string.match(n.name, "%a-brick") ~= nil then
					if value ~= "rose" then
						minetest.env:remove_node(pointed_thing)
						minetest.env:add_node(pointed_thing.under, {name="home_mod:" .. key .. "_brick"})
						return add_to_inventory(player,item,'home_mod:can 1')
					end
				end
			end
			return item
		end,
	})
end


minetest.register_craft({
	output = 'home_mod:chisel 1',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'' , 'default:steel_ingot', '' },
		{'' , 'default:stick', '' }
	}
})

minetest.register_craft({
	output = 'default:mossycobble 1',
	recipe = {
		{'bucket:bucket_water'},
		{'home_mod:moss' },
		{'default:cobble' }
	}
})

minetest.register_craft({
	output = 'home_mod:scoop 1',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'' , 'default:stick', '' }
	}
})

minetest.register_craft({
	output = 'home_mod:dustbin 1',
	recipe = {
		{'default:cactus', 'default:cactus', 'default:cactus'},
		{'default:cactus', '', 'default:cactus' },
		{'default:cactus', 'default:cactus', 'default:cactus' }
	}
})

minetest.register_craft({
	output = 'home_mod:glass_pane 1',
	recipe = {
		{'default:glass', 'default:glass', 'default:glass'},
		{'default:glass', 'default:glass', 'default:glass'}
	}
})

minetest.register_craft({
	output = 'home_mod:fireplace 1',
	recipe = {
		{'default:brick', 'default:brick', 'default:brick'},
		{'default:brick', 'default:torch', 'default:brick'},
		{'default:brick', 'default:brick', 'default:brick'},
	}
})


----------------------------

minetest.register_node("home_mod:glass_pane", {
	description = "Glass pane",
	drawtype = "signlike",
	tile_images = {"default_glass.png"},
	inventory_image = "default_glass.png",
	paramtype = "light",
	paramtype2 = 'wallmounted',
	is_ground_content = true,
	sunlight_propagates = true,
	walkable = true,
	drop = 'home_mod:glass_pane 1',
	material = minetest.digprop_glasslike(1.0),
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
})

minetest.register_node("home_mod:dustbin", {
	description = "Dustbin",
	tile_images = {"dustbin_top.png", "dustbin_down.png", "dustbin_side.png",
		"dustbin_side.png", "dustbin_back.png", "dustbin_front.png"},
	inventory_image = minetest.inventorycube("dustbin_top.png", "dustbin_front.png", "dustbin_side.png"),
	paramtype = "facedir_simple",
	metadata_name = "chest",
	material = minetest.digprop_woodlike(1.0),
})

minetest.register_craft({
	type = "fuel",
	recipe = "home_mod:dustbin",
	burntime = 30,
})

	
minetest.register_node("home_mod:fireplace", {
	description = "Fireplace",
	tile_images = {"default_brick.png", "default_brick.png", "default_brick.png",
		"default_brick.png", "default_brick.png", "default_brick.png^fireplace_front.png"},
	inventory_image = minetest.inventorycube("default_brick.png", "default_brick.png^fireplace_front.png", "default_brick.png"),
	paramtype = "facedir_simple",
	light_source = LIGHT_MAX,
	material = minetest.digprop_stonelike(3.0),
})



--------------------------------------

minetest.register_craftitem("home_mod:moss", {
	description = "Moss",
	inventory_image = "moss.png",
	on_place = minetest.item_place,
})

minetest.register_craftitem("home_mod:chisel", {
	description = "Chisel",
	inventory_image = "chisel.png",
	on_place = minetest.item_place,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:mossycobble" then
				minetest.env:add_node(pointed_thing.under, {name="default:cobble", param2=n.param2})
				return add_to_inventory(player,'home_mod:moss 1')
            elseif string.match(n.name, "%a-wood") ~= nil then
				if string.match(n.name, "%a-fence_wood") ~= nil then
                			minetest.env:add_node(pointed_thing.under, {name="default:fence_wood", param2=n.param2})
				else
                			minetest.env:add_node(pointed_thing.under, {name="default:wood", param2=n.param2})
				end
            		elseif string.match(n.name, "%a-cobble") ~= nil then
                		minetest.env:add_node(pointed_thing.under, {name="default:cobble", param2=n.param2})
            		elseif string.match(n.name, "%a-steelblock") ~= nil then
                		minetest.env:add_node(pointed_thing.under, {name="default:steelblock", param2=n.param2})
            		elseif string.match(n.name, "%a-stone") ~= nil then
                		minetest.env:add_node(pointed_thing.under, {name="default:stone", param2=n.param2})
            		elseif string.match(n.name, "%a-tree") ~= nil then
                		minetest.env:add_node(pointed_thing.under, {name="default:tree", param2=n.param2})
            		elseif string.match(n.name, "%a-brick") ~= nil then
                		minetest.env:add_node(pointed_thing.under, {name="default:brick", param2=n.param2})
			end
		end
		return item
	end,
})

minetest.register_craftitem("home_mod:can", {
	description = "Can",
	inventory_image = "can.png",
	on_place = minetest.item_place,
})


minetest.register_craftitem("home_mod:scoop", {
	description = "Scoop",
    inventory_image = "scoop.png",
    on_place = minetest.item_place,
    on_use = function(item, player, pointed_thing)
        if pointed_thing.type == "node" then
            n = minetest.env:get_node(pointed_thing.under)
            if string.match(n.name, "home_mod:dustbin") ~= nil then
                minetest.env:remove_node(pointed_thing)
                minetest.env:add_node(pointed_thing.under, {name="home_mod:dustbin", param2=n.param2})
            end
        end
        return false
    end,

})

print("[Home mod] Loaded!")
