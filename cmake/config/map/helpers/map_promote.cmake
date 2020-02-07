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

macro(map_promote __map_promote_map)
  # garbled names help free from variable collisions
  map_keys(${__map_promote_map} )
  ans(__map_promote_keys)
  foreach(__map_promote_key ${__map_promote_keys})
    map_get(${__map_promote_map}  ${__map_promote_key})
    ans(__map_promote_value)
    set("${__map_promote_key}" "${__map_promote_value}" PARENT_SCOPE)
  endforeach()
endmacro()
