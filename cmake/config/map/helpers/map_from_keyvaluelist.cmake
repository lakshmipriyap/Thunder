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

# adds the keyvalues list to the map (if not map specified created one)
function(map_from_keyvaluelist map)
  if(NOT map)
    map_new()
    ans(map)
  endif()
  set(args ${ARGN})
  while(true)
    list_pop_front(args)
    ans(key)
    list_pop_front(args)
    ans(val)
    if(NOT key)
      break()
    endif()
    map_set("${map}" "${key}" "${val}")
  endwhile()
  return_ref(map)
endfunction()
