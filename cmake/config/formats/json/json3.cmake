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

function(json3_cached)
  define_cache_function(json3_cached json3)
  json3_cached("${ARGN}")
  return_ans()
endfunction()
## 
##
## fast json parser
function(json3 input)
  string_encode_list("${input}")
  ans(input)
  string_codes()
  regex_json()
  string(REGEX MATCHALL "${regex_json_literal}" literals "${input}")
  string(REGEX REPLACE "${regex_json_literal}" "${free_token}" input "${input}" )
  string(REGEX REPLACE "(.)" "\\1;" tokens "${input}")
  address_new()
  ans(base)
  set(ref ${base})
  set(ref_stack)
  #address_new()
  #ans(cmake_serialized)
  while(true)
    list(LENGTH tokens len)
    if(NOT len)
      break()
    endif()
    list(GET tokens 0 token)
    list(REMOVE_AT tokens 0)
    if("${token}" STREQUAL "{")
      list(INSERT ref_stack 0 ${ref})
      map_new()
      ans(value)
      set_property(GLOBAL APPEND_STRING PROPERTY "${ref}" "${value}")
      set(ref ${value})
    elseif("${token}" STREQUAL "}")
      if("${ref}" MATCHES ".[0-9]+\\..+")
        list(GET ref_stack 0 ref)
        list(REMOVE_AT ref_stack 0)
      endif()
      list(GET ref_stack 0 ref)
      list(REMOVE_AT ref_stack 0)
    elseif("${token}" STREQUAL "${free_token}")
      list(GET literals 0 value)
      list(REMOVE_AT literals 0)
      list(GET tokens 0 next_token)
      if("${next_token}" STREQUAL ":" AND NOT "${value}" MATCHES "\".*\"")
        message(FATAL_ERROR "expected key to be a string instead got '${value}'")
      elseif("${next_token}" STREQUAL ":")
        list(REMOVE_AT tokens 0)
        json_string_to_cmake("${value}")
        ans(key)
        list(INSERT ref_stack 0 ${ref})
        set_property(GLOBAL APPEND PROPERTY "${ref}" "${key}")
        set(ref "${ref}.${key}")
      else()
        if("${value}" MATCHES \".*\")
          json_string_to_cmake("${value}")
          ans(value)
          string_decode_list("${value}")
          ans(value)
        elseif("${value}" STREQUAL "null")
          set(value)
        endif()
        set_property(GLOBAL APPEND_STRING PROPERTY "${ref}" "${value}")
      endif()
    elseif("${token}" STREQUAL ":")
      messaGE(FATAL_ERROR "unexpected ':'")
    elseif("${token}" STREQUAL ",")
      if("${ref}" MATCHES ".[0-9]+\\..+")
        list(GET ref_stack 0 ref)
        list(REMOVE_AT ref_stack 0)
      else()
        set_property(GLOBAL APPEND_STRING PROPERTY "${ref}" ";")
      endif()
    elseif("${token}" STREQUAL "${bracket_open_code}")  
      list(INSERT ref_stack 0 ${ref})
      address_new()
      ans(ref)
    elseif("${token}" STREQUAL "${bracket_close_code}")  
      get_property(values GLOBAL PROPERTY "${ref}")
      list(GET ref_stack 0 ref)
      list(REMOVE_AT ref_stack 0)
      set_property(GLOBAL APPEND_STRING PROPERTY "${ref}" "${values}")
    endif()
  endwhile()
  address_get(${base})
  return_ans()
endfunction()

