minetest.register_tool("weapons:lightsaber_red", {
	description = "Red Lightsaber",
	inventory_image = "red_lightsaber.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[1]=0.7, [2]=0.20, [3]=0.05}, maxwear=0.1, maxlevel=3},
			snappy={times={[2]=0.45, [3]=0.15}, maxwear=0.02, maxlevel=3},
			choppy={times={[3]=0.45}, maxwear=0.02, maxlevel=3}
		}
	}
})

minetest.register_tool("weapons:lightsaber_blue", {
	description = "Blue Lightsaber",
	inventory_image = "blue_lightsaber.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[1]=0.7, [2]=0.20, [3]=0.05}, maxwear=0.1, maxlevel=3},
			snappy={times={[2]=0.45, [3]=0.15}, maxwear=0.02, maxlevel=3},
			choppy={times={[3]=0.45}, maxwear=0.02, maxlevel=3}
		}
	}
})

minetest.register_node("weapons:stone_blue_crystal", {
	description = "Blue Crystal in Stone",
	tile_images = {"default_stone.png^stone_blue_crystal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'weapons:blue_crystal',
	legacy_mineral = true,
})

minetest.register_node("weapons:stone_red_crystal", {
	description = "Red Crystal in Stone",
	tile_images = {"default_stone.png^stone_red_crystal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'weapons:red_crystal',
	legacy_mineral = true,
})

minetest.register_craftitem("weapons:handle", {
	description = "Lightsaber Handle",
	inventory_image = "handle.png",
})

minetest.register_craftitem("weapons:blue_crystal", {
	description = "Blue Crystal",
	inventory_image = "blue_crystal.png",
})

minetest.register_craftitem("weapons:red_crystal", {
	description = "Red Crystal",
	inventory_image = "red_crystal.png",
})
minetest.add_to_creative_inventory("weapons:red_crystal")
minetest.add_to_creative_inventory("weapons:blue_crystal")
minetest.add_to_creative_inventory("weapons:handle")

------------------------------------------------------------
--recipes
minetest.register_craft{
	output		= "weapons:lightsaber_red",
	recipe		= {
			{"weapons:red_crystal"},
			{"weapons:red_crystal"},
			{"weapons:handle"},
			}
}

minetest.register_craft{
	output		= "weapons:lightsaber_blue",
	recipe		= {
			{"weapons:blue_crystal"},
			{"weapons:blue_crystal"},
			{"weapons:handle"},
			}
}

minetest.register_craft{
	output		= "weapons:handle",
	recipe		= {
			{"default:stone"},
			}
}
----------------------------------------------------------------------------------------
--Generation

local bluecrystal = {

        "weapons:stone_blue_crystal"

}

local bluecrystal_gen = function( minp, maxp )

        for c, bcrystal in ipairs(bluecrystal) do

                local amount = math.random( 0, 25 )

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

                                                                minetest.env:add_node( p, { name = bcrystal } )

                                                        end

                                                end

                                        end

                                end

                        end

                end

        end

end

minetest.register_on_generated( bluecrystal_gen )


