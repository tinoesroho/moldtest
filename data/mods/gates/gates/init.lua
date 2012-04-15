-- gates
-- By Splizard
-- Forum post: http://c55.me/minetest/forum/viewtopic.php?id=896
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--      
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--      
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
-- MA 02110-1301, USA.
--      

-- Quick documentation about the API
-- =================================:
--
-- Create new gate:
--
-- gates.register_node(yourmod:gate, {
--     #shared node options go here
--
--	   description = "A Gate",
--     groups = {choppy=2,dig_immediate=2},
--     drop = "yourmod:gate", #Without this you can pick up open gates
--
-- },
-- {
--     #open gate options go here
--
--     tile_images = {'open_gate.png'}, 
--	   walkable = false,
--     drawtype = "plantlike",
-- },
-- {
--     #closed gate options go here
--
--     tile_images = {'closed_gate_top.png','closed_gate_bottom.png','closed_gate_sides.png'}, 
--	   walkable = true,
-- },
-- }, "on_punch") #The mode to switch the gate eg. on_punch, on_mesecon_signal, on_whatever
--
--
--	If you want to switch the gate with another callback, use:
--  gates.toggle(pos, node, player, mode) #Same mode that you used to register the node
--

-- Definitions made by this mod that other mods can use too
gates = {}
gates.registered_nodes = {}
gates.registered_nodes["on_punch"] = {}
gates.registered_nodes["on_mesecon"] = {}


--
-- Api functions
--
gates.register_node = function(name, shared, open, closed, mode)
	if name ~= nil then
		if mode == nil then mode = "on_punch" end
		
		--Creates two nodes, open and closed node
		for i,v in pairs(shared) do open[i] = v end
		minetest.register_node(name.."_open", open)
		
		for i,v in pairs(shared) do closed[i] = v end
		minetest.register_node(name, closed)
		
		--Index nodes
		gates.registered_nodes[mode][name] = name.."_open"
		gates.registered_nodes[mode][name.."_open"] = name
	else
		minetest.log(LOGLEVEL_ERROR,"GATES: in function \"gates.register_node\": missing node name!")
	end
end

local gate_punched = function(pos, node, puncher)
	if gates.registered_nodes["on_punch"][node.name] ~= nil then
		minetest.env:add_node(pos, {
			name = gates.registered_nodes["on_punch"][node.name],
		})
		
		 --handle gates above this one
		local lpos = pos
		while true do
			lpos.y = lpos.y + 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes["on_punch"][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes["on_punch"][node.name],
				})
			else break
			end
		end
		
		 --handle gates below this one
		local lpos = pos
		while true do
			lpos.y = lpos.y - 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes["on_punch"][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes["on_punch"][node.name],
				})
			else break
			end
		end
		
	end
end

gates.toggle = function(pos, node, puncher, mode)
	if gates.registered_nodes[mode][node.name] ~= nil then
		minetest.env:add_node(pos, {
			name = gates.registered_nodes[mode][node.name],
		})
				
		--handle gates above this one
		local lpos = pos
		while true do
			lpos.y = lpos.y + 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes[mode][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes[mode][node.name],
				})
			else break
			end
		end
		
		 --handle gates below this one
		local lpos = pos
		while true do
			lpos.y = lpos.y - 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes[mode][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes[mode][node.name],
				})
			else break
			end
		end
	end
end

-- 
-- Nodes
--
gates.register_node('gates:gate', {
	description = "Gate",
    groups = {choppy=2,dig_immediate=2},
    drop = "gates:gate",
},
{
    drawtype = 'plantlike',
    sunlight_propagates = true,
    paramtype = 'light',
    visual_scale = 1.5,
	tile_images = {'gate_open.png'},
	walkable = false,
},
{
	tile_images = {'gate_top.png','gate_top.png','gate.png'},
	walkable = true,
})


--
-- Crafts
--
minetest.register_craft({
    output = '"gates:gate" 2',
    recipe = {
        {"default:stick", "default:wood", "default:stick"},
        {"default:stick", "default:wood", "default:stick"},
    },
})

-- Change the gate state
minetest.register_on_punchnode(gate_punched)
