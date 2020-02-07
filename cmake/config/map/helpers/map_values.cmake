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

# returns all values of the map which are passed as ARNG
function(map_values this)
  set(args ${ARGN})
  if(NOT args)
    map_keys(${this})
    ans(args)
  endif()
  set(res)
	foreach(arg ${args})
		map_get(${this}  ${arg})
    ans(val)
		list(APPEND res ${val})	
	endforeach()
  return_ref(res)
endfunction()


# ## faster
# macro(map_values map)
#   set(__ans ${ARGN})
#   if(NOT __ans)
#     map_keys(${map})
#   endif()
#   ## ____map_values_key does not conflict as it is the loop variable
#   foreach(____map_values_key ${__ans})
#     map_tryget(${map} ${____map_values_key})
#     list(APPEND __map_values_result ${__ans})
#   endforeach()
#   set(__ans ${__map_values_result})
# endmacro()
