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

## `()-><bool>`
##
## sets the value of the specified prop if it does not exist
## ie if map_has returns false for the specified property
## returns true iff value was set
function(map_set_default map prop)
  map_has("${map}" "${prop}")
  if(__ans)
    return(false)
  endif()
  map_set("${map}" "${prop}" ${ARGN})
  return(true)
endfunction()
