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

## captures a new map from the given variables
## example
## set(a 1)
## set(b 2)
## set(c 3)
## map_capture_new(a b c)
## ans(res)
## json_print(${res})
## --> 
## {
##   "a":1,
##   "b":2,
##   "c":3 
## }
function(map_capture_new)
  map_new()
  ans(__map_capture_new_map)
  map_capture(${__map_capture_new_map} ${ARGN})
  return(${__map_capture_new_map})
endfunction()
