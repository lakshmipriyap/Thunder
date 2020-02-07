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

# returns a map with all properties except those matched by any of the specified regexes
function(map_omit_regex map)
  set(regexes ${ARGN})
  map_keys("${map}")
  ans(keys)

  foreach(regex ${regexes})
    foreach(key ${keys})
        if("${key}" MATCHES "${regex}")
          list_remove(keys "${key}")
        endif()
    endforeach()
  endforeach()


  map_pick("${map}" ${keys})

  return_ans()


endfunction()
