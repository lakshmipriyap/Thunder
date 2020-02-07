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

function(map_issubsetof result superset subset)
	map_keys(${subset} )
	ans(keys)
	foreach(key ${keys})
		map_tryget(${superset}  ${key})
		ans(superValue)
		map_tryget(${subset}  ${key})
		ans(subValue)

		is_map(${superValue} )
		ans(issupermap)
		is_map(${subValue} )
		ans(issubmap)
		if(issubmap AND issubmap)
			map_issubsetof(res ${superValue} ${subValue})
			if(NOT res)
				return_value(false)
			endif()
		else()
			list_isvalid(${superValue} )
			ans(islistsuper)
			list_isvalid(${subValue} )
			ans(islistsub)
			if(islistsub AND islistsuper)
				address_get(${superValue})
				ans(superValue)
				address_get(${subValue})
				ans(subValue)
			endif()
			list_equal( "${superValue}" "${subValue}")
			ans(res)
			if(NOT res)
				return_value(false)
			endif()
		endif()
	endforeach()
	return_value(true)
endfunction()
