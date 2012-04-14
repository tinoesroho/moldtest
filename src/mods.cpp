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

#include "mods.h"
#include <queue>
#include <fstream>
#include <sstream>
#include <map>
#include "filesys.h"
#include "strfnd.h"
#include "log.h"

// Get a dependency-sorted list of ModSpecs
core::list<ModSpec> getMods(core::list<std::string> &modspaths)
		throw(ModError)
{
	std::queue<ModSpec> mods_satisfied;
	core::list<ModSpec> mods_unsorted;
	core::list<ModSpec> mods_sorted;
	// name, path: For detecting name conflicts
	std::map<std::string, std::string> mod_names;
	for(core::list<std::string>::Iterator i = modspaths.begin();
			i != modspaths.end(); i++){
		std::string modspath = *i;
		std::vector<fs::DirListNode> dirlist = fs::GetDirListing(modspath);
		for(u32 j=0; j<dirlist.size(); j++){
			if(!dirlist[j].dir)
				continue;
			std::string modname = dirlist[j].name;
			std::string modpath = modspath + DIR_DELIM + modname;
			// Detect mod name conflicts
			{
				std::map<std::string, std::string>::const_iterator i;
				i = mod_names.find(modname);
				if(i != mod_names.end()){
					std::string s;
					infostream<<"WARNING: Mod name conflict detected: "
							<<std::endl
							<<"Already loaded: "<<i->second<<std::endl
							<<"Will not load: "<<modpath<<std::endl;
					continue;
				}
			}
			std::set<std::string> depends;
			std::ifstream is((modpath+DIR_DELIM+"depends.txt").c_str(),
					std::ios_base::binary);
			while(is.good()){
				std::string dep;
				std::getline(is, dep);
				dep = trim(dep);
				if(dep != "")
					depends.insert(dep);
			}
			ModSpec spec(modname, modpath, depends);
			mods_unsorted.push_back(spec);
			if(depends.empty())
				mods_satisfied.push(spec);
			mod_names[modname] = modpath;
		}
	}
	// Sort by depencencies
	while(!mods_satisfied.empty()){
		ModSpec mod = mods_satisfied.front();
		mods_satisfied.pop();
		mods_sorted.push_back(mod);
		for(core::list<ModSpec>::Iterator i = mods_unsorted.begin();
				i != mods_unsorted.end(); i++){
			ModSpec &mod2 = *i;
			if(mod2.unsatisfied_depends.empty())
				continue;
			mod2.unsatisfied_depends.erase(mod.name);
			if(!mod2.unsatisfied_depends.empty())
				continue;
			mods_satisfied.push(mod2);
		}
	}
	std::ostringstream errs(std::ios::binary);
	// Check unsatisfied dependencies
	for(core::list<ModSpec>::Iterator i = mods_unsorted.begin();
			i != mods_unsorted.end(); i++){
		ModSpec &mod = *i;
		if(mod.unsatisfied_depends.empty())
			continue;
		errs<<"mod \""<<mod.name
				<<"\" has unsatisfied dependencies:";
		for(std::set<std::string>::iterator
				i = mod.unsatisfied_depends.begin();
				i != mod.unsatisfied_depends.end(); i++){
			errs<<" \""<<(*i)<<"\"";
		}
		errs<<"."<<std::endl;
		mods_sorted.push_back(mod);
	}
	if(errs.str().size() != 0){
		throw ModError(errs.str());
	}
	return mods_sorted;
}


