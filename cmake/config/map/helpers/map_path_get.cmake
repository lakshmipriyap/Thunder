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

# returns the value at the specified path (path is specified as path fragment list)
# e.g. map = {a:{b:{c:{d:{e:3}}}}}
# map_path_get(${map} a b c d e)
# returns 3
# this function is somewhat faster than map_navigate()
function(map_path_get map)
  set(args ${ARGN})
  set(current "${map}")
  foreach(arg ${args}) 
    if(NOT current)
      return()
   endif()
   map_tryget("${current}" "${arg}")
   ans(current)
  endforeach()
  return_ref(current)
endfunction()
