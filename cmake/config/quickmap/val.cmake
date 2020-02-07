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

function(val)
  # appends the values to the current_map[current_key]
  stack_peek(:quick_map_map_stack)
  ans(current_map)
  stack_peek(:quick_map_key_stack)
  ans(current_key)
  if(NOT current_map)
    set(res ${ARGN})
    return_ref(res)
  endif()
  map_append("${current_map}" "${current_key}" "${ARGN}")
endfunction()



## val(<val ...>) -> <any...>
##
## adds a val to current property or ref
##
function(val)
  set(args ${ARGN})
  stack_peek(quickmap)
  ans(current_ref)
  
  if(NOT current_ref)
    return()
  endif()
  ## todo check if map 
  address_append("${current_ref}" ${args})
  return_ref(args)
endfunction()
