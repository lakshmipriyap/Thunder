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

function(end)
  # remove last key from key stack and last map from map stack
  # return the popped map
  stack_pop(:quick_map_key_stack)
  stack_pop(:quick_map_map_stack)
  return_ans()
endfunction()



## end() -> <current value>
##
## ends the current key, ref or map and returns the value
## 
function(end)
  stack_pop(quickmap)
  ans(ref)

  if(NOT ref)
    message(FATAL_ERROR "end() not possible ")
  endif()
    
  string_take_address(ref)
  ans(current_ref)

  return_ref(current_ref)
endfunction()
