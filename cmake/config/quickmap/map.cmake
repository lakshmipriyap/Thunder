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

function(map)
  set(key ${ARGN})

  # get current map
  stack_peek(:quick_map_map_stack)
  ans(current_map)

  # get current key
  stack_peek(:quick_map_key_stack)
  ans(current_key)

  if(ARGN)
    set(current_key ${ARGV0})
  endif()

  # create new current map
  map_new()
  ans(new_map)


  # add map to existing map
  if(current_map)
    key("${current_key}")
    val("${new_map}")
  endif()


  # push new map and new current key on stacks
  stack_push(:quick_map_map_stack ${new_map})
  stack_push(:quick_map_key_stack "")

  return_ref(new_map)
endfunction()



## map() -> <address>
## 
## begins a new map returning its address
## map needs to be ended via end()
function(map)
  if(NOT ARGN STREQUAL "")
    key("${ARGN}")
  endif()
  map_new()
  ans(ref)
  val(${ref})
  stack_push(quickmap ${ref})
  return_ref(ref)
endfunction()
