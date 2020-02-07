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

# returns a copy of map with key values inverted
# only works correctly for bijective maps
function(map_invert map)
  map_keys("${map}")
  ans(keys)
  map_new()
  ans(inverted_map)
  foreach(key ${keys})
    map_tryget("${map}" "${key}")
    ans(val)
    map_set("${inverted_map}" "${val}" "${key}")
  endforeach()
  return_ref(inverted_map)
endfunction()
