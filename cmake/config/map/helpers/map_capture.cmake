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

## captures the listed variables in the map
function(map_capture map )
  set(__map_capture_args ${ARGN})
  list_extract_flag(__map_capture_args --reassign)
  ans(__reassign)
  list_extract_flag(__map_capture_args --notnull)
  ans(__not_null)
  foreach(__map_capture_arg ${__map_capture_args})
    
    if(__reassign AND "${__map_capture_arg}" MATCHES "(.+)[:=](.+)")
      set(__map_capture_arg_key ${CMAKE_MATCH_1})
      set(__map_capture_arg ${CMAKE_MATCH_2})
    else()
      set(__map_capture_arg_key "${__map_capture_arg}")
    endif()
   # print_vars(__map_capture_arg __map_capture_arg_key)
    if(NOT __not_null OR NOT "${${__map_capture_arg}}_" STREQUAL "_")
      map_set(${map} "${__map_capture_arg_key}" "${${__map_capture_arg}}")
    endif()
  endforeach()
endfunction()

