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

function(stack_pop stack)
  map_tryget("${stack}" back)
  ans(current_index)
  if(NOT current_index)
    return()
  endif()
  map_tryget("${stack}" "${current_index}")
  ans(res)
  math(EXPR current_index "${current_index} - 1")
  map_set_hidden("${stack}" back "${current_index}")
  return_ref(res)
endfunction()
