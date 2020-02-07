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

# appends a value to the end of a map entry
function(map_append map key)
  get_property(isset GLOBAL PROPERTY "${map}.${key}" SET)
	if(NOT isset)
		map_set(${map} ${key} ${ARGN})
		return()
	endif()
  set_property(GLOBAL APPEND PROPERTY "${map}.${key}" ${ARGN})
endfunction()
