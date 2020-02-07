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

function(map_clone_shallow original)
  is_map("${original}" )
  ans(ismap)
  if(ismap)
    map_new()
    ans(result)
    map_keys("${original}" )
    ans(keys)
    foreach(key ${keys})
      map_get("${original}"  "${key}")
      ans(value)
      map_set("${result}" "${key}" "${value}")
    endforeach()
    return(${result})
  endif()

  is_address("${original}")
  ans(isref)
  if(isref)
    address_get(${original})
    ans(res)
    address_type_get(${original})
    ans(type)
    address_new(${type})
    ans(result)
    address_set(${result} ${res})
    return(${result})
  endif()

  # everythign else is a value type and can be returned
  return_ref(original)

endfunction()

