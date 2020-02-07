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

## `(<map> <key>)-><map>`
##
## returns a map for the specified key
## creating it if it does not exist
##
function(map_get_map map key)
  map_tryget(${map} ${key})
  ans(res)
  is_address("${res}")
  ans(ismap)
  if(NOT ismap)
    map_new()
    ans(res)
    map_set(${map} ${key} ${res})
  endif()
  return_ref(res)
endfunction()

