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

# returns true if map's properties match all properties of attrs
function(map_match_properties map attrs)
  map_keys("${attrs}")
  ans(attr_keys)
  foreach(key ${attr_keys})

    map_tryget("${map}" "${key}")
    ans(val)
    map_tryget("${attrs}" "${key}")
    ans(pred)
   # message("matching ${map}'s ${key} '${val}' with ${pred}")
    if(NOT "${val}" MATCHES "${pred}")
      return(false)
    endif()
  endforeach()
  return(true)
endfunction()

