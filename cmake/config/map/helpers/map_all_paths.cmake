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

# returns all possible paths for the map
# (currently crashing on cycles cycles)
# todo: implement
function(map_all_paths)
  message(FATAL_ERROR "map_all_paths is not implemented yet")

  function(_map_all_paths event)
    if("${event}" STREQUAL "map_element_begin")
      address_get(${current_path})
      ans(current_path)
      set(cu)
    endif()
    if("${event}" STREQUAL "value")
      address_new(${})
    endif()
  endfunction()

  address_new()
  ans(current_path)
  address_new()
  ans(path_list)

  dfs_callback(_map_all_paths ${ARGN})
endfunction()
