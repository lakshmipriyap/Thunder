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

  ## checks if all fields specified in actual rhs are equal to the values in expected lhs
  ## recursively checks submaps
  function(map_match lhs rhs)
    if("${lhs}_" STREQUAL "${rhs}_")
      return(true)
    endif()


    list(LENGTH lhs lhs_length)
    list(LENGTH rhs rhs_length)

    if(NOT "${lhs_length}" EQUAL "${rhs_length}")
      return(false)
    endif()
  
    if(${lhs_length} GREATER 1)
      while(true)
        list(LENGTH lhs len)
        if(NOT len)
          break()
        endif()

        list_pop_back(lhs)
        ans(lhs_value)
        list_pop_back(rhs)
        ans(rhs_value)
        map_match("${lhs_value}" "${rhs_value}")
        ans(is_match)
        if(NOT is_match)
          return(false)
        endif()
      endwhile()
      return(true)
    endif() 

    is_map("${rhs}")
    ans(rhs_ismap)

    is_map("${lhs}")
    ans(lhs_ismap)

  
    if(NOT lhs_ismap OR NOT rhs_ismap)
      return(false)
    endif()


    map_iterator(${rhs})
    ans(it)

    while(true)
      map_iterator_break(it)

      map_tryget("${lhs}" "${it.key}")
      ans(lhs_value)

      map_match("${lhs_value}" "${it.value}")
      ans(values_match)

      if(NOT values_match)
        return(false)
      endif()

    endwhile()

    return(true)

  endfunction()
