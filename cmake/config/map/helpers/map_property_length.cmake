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

  ## returns the length of the specified property
  function(map_property_length map prop)
    map_tryget("${map}" "${prop}")
    ans(val)
    list(LENGTH val len)
    return_ref(len)
  endfunction()


  macro(map_property_length map prop)
    get_property(__map_property_length_value GLOBAL PROPERTY "${map}.${prop}")
    list(LENGTH __map_property_length_value __ans)
  endmacro()


  macro(map_property_string_length map prop)
    get_property(__map_property_length_value GLOBAL PROPERTY "${map}.${prop}")
    string(LENGTH "${__map_property_length_value}" __ans)
  endmacro()
