/*
Minetest-c55
Copyright (C) 2011 celeron55, Perttu Ahola <celeron55@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/

#include "luaentity_common.h"

#include "utility.h"

#define PP(x) "("<<(x).X<<","<<(x).Y<<","<<(x).Z<<")"
#define PP2(x) "("<<(x).X<<","<<(x).Y<<")"

LuaEntityProperties::LuaEntityProperties():
	physical(false),
	weight(5),
	collisionbox(-0.5,-0.5,-0.5, 0.5,0.5,0.5),
	visual("sprite"),
	visual_size(1,1),
	spritediv(1,1),
	initial_sprite_basepos(0,0)
{
	textures.push_back("unknown_object.png");
}

std::string LuaEntityProperties::dump()
{
	std::ostringstream os(std::ios::binary);
	os<<"physical="<<physical;
	os<<", weight="<<weight;
	os<<", collisionbox="<<PP(collisionbox.MinEdge)<<","<<PP(collisionbox.MaxEdge);
	os<<", visual="<<visual;
	os<<", visual_size="<<PP2(visual_size);
	os<<", textures=[";
	for(u32 i=0; i<textures.size(); i++){
		os<<"\""<<textures[i]<<"\" ";
	}
	os<<"]";
	os<<", spritediv="<<PP2(spritediv);
	os<<", initial_sprite_basepos="<<PP2(initial_sprite_basepos);
	return os.str();
}

void LuaEntityProperties::serialize(std::ostream &os)
{
	writeU8(os, 0); // version
	writeU8(os, physical);
	writeF1000(os, weight);
	writeV3F1000(os, collisionbox.MinEdge);
	writeV3F1000(os, collisionbox.MaxEdge);
	os<<serializeString(visual);
	writeV2F1000(os, visual_size);
	writeU16(os, textures.size());
	for(u32 i=0; i<textures.size(); i++){
		os<<serializeString(textures[i]);
	}
	writeV2S16(os, spritediv);
	writeV2S16(os, initial_sprite_basepos);
}

void LuaEntityProperties::deSerialize(std::istream &is)
{
	int version = readU8(is);
	if(version != 0) throw SerializationError(
			"unsupported LuaEntityProperties version");
	physical = readU8(is);
	weight = readF1000(is);
	collisionbox.MinEdge = readV3F1000(is);
	collisionbox.MaxEdge = readV3F1000(is);
	visual = deSerializeString(is);
	visual_size = readV2F1000(is);
	textures.clear();
	u32 texture_count = readU16(is);
	for(u32 i=0; i<texture_count; i++){
		textures.push_back(deSerializeString(is));
	}
	spritediv = readV2S16(is);
	initial_sprite_basepos = readV2S16(is);
}


