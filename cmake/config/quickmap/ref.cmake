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

## ref() -> <address> 
## 
## begins a new reference value and returns its address
## ref needs to be ended via end() call
function(ref)
  if(NOT ARGN STREQUAL "")
    key("${ARGN}")
  endif()
  address_new()
  ans(ref)
  val(${ref})
  stack_push(quickmap ${ref})   
  return_ref(ref)
endfunction()
