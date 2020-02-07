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

function(key key)
  # check if there is a current map
  stack_peek(:quick_map_map_stack)
  ans(current_map)
  if(NOT current_map)
    message(FATAL_ERROR "cannot set key for non existing map be sure to call first map() before first key()")
  endif()
  # set current key
  stack_pop(:quick_map_key_stack)
  stack_push(:quick_map_key_stack "${key}")
endfunction()


## key() -> <void>
##
## starts a new property for a map - may only be called
## after key or map
## fails if current ref is not a map
function(key key)
  stack_pop(quickmap)
  ans(current_key)

  string_take_address(current_key)
  ans(current_ref)
 
  #is_map("${current_ref}")
  is_address("${current_ref}")
  ans(ismap)
  if(NOT ismap)
    message(FATAL_ERROR "expected a map before key() call")
  endif()


  map_set("${current_ref}" "${key}" "")
  stack_push(quickmap "${current_ref}.${key}")
  return()
endfunction()
