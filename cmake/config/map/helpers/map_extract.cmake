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

function(map_extract navigation_expressions)
  cmake_parse_arguments("" "REQUIRE" "" "" ${ARGN})
  set(args ${_UNPARSED_ARGUMENTS})
  foreach(navigation_expression ${navigation_expressions})
    map_navigate(res "${navigation_expression}")
    list_pop_front( args)
    ans(current)
    if(_REQUIRE AND NOT res)
      message(FATAL_ERROR "map_extract failed: requires ${navigation_expression}")
    endif()

    if(current)
      set(${current} ${res} PARENT_SCOPE)
    else()
      if(NOT _REQUIRE)
       break()
      endif()
    endif()
  endforeach()
  foreach(arg ${args})
    set(${arg} PARENT_SCOPE)  
  endforeach()
  
endfunction()
