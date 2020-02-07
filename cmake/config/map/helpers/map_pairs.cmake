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

# returns a list key;value;key;value;...
# only works if key and value are not lists (ie do not contain ;)
function(map_pairs map)
  map_keys("${map}")
  ans(keys)
  set(pairs)
  foreach(key ${keys})
    map_tryget("${map}" "${key}")
    ans(val)
    list(APPEND pairs "${key}")
    list(APPEND pairs "${val}")
  endforeach()
  return_ref(pairs)
endfunction()
