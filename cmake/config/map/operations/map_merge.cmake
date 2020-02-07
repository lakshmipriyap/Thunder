# If not stated otherwise in this file or this component's license file the
# following copyright and licenses apply:
#
# Copyright 2020 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# creates a union from all all maps passed as ARGN and combines them in result
# you can merge two maps by typing map_union(${map1} ${map1} ${map2})
# maps are merged in order ( the last one takes precedence)
function(map_merge )
	set(lst ${ARGN})

	map_new()
  ans(res)
  
	foreach(map ${lst})
		map_keys(${map} )
		ans(keys)
		foreach(key ${keys})
			map_tryget(${res}  ${key})
			ans(existing_val)
			map_tryget(${map}  ${key})
			ans(val)

			is_map("${existing_val}" )
			ans(existing_ismap)
			is_map("${val}" )
			ans(new_ismap)

			if(new_ismap AND existing_ismap)
				map_union(${existing_val}  ${val})
				ans(existing_val)
			else()
				
				map_set(${res} ${key} ${val})
			endif()
		endforeach()
	endforeach()
	return(${res})
endfunction()

