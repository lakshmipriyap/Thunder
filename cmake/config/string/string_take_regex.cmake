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

## `(<str_name:<string&>> <regex:<string>> <replace:<string>>)-><str_name:<string&>> <string>`
##
## Tries to match the regex at the begging of ${${str_name}} and returns the match.
## Side effect: Input reference ${str_name} is shortened in the process.
## See **Examples** for passing references.
##
## **Examples**
##  set(in_ref_str "keep_two_whitespaces  ")
##  string_take_regex(in_ref_str "[^ ]*" "") # => in_ref_str equals "  "
##
##
function(string_take_regex str_name regex)
  string(REGEX MATCH "^(${regex})" match "${${str_name}}")
  string(LENGTH "${match}" len)
  if(len)
    string(SUBSTRING "${${str_name}}" ${len} -1 res )
    set(${str_name} "${res}" PARENT_SCOPE)
    return_ref(match)
  endif()
  return()
endfunction()

# faster version
function(string_take_regex_replace str_name regex replace)
  string_take_regex(${str_name} "${regex}")
  ans(match)
  if("${match}_" STREQUAL _)
    return()
  endif()
  set(${str_name} "${${str_name}}" PARENT_SCOPE)
  string(REGEX REPLACE "${regex}" "${replace}" match "${match}")
  return_ref(match)
endfunction()

## fasterversion does not work in case of nested regex parenthesis
## and unknown matchgroup of rest string
# function(string_take_regex str_name regex)
#   if("${${str_name}}" MATCHES "^(${regex})(.*)$")
#     set(${str_name} "${CMAKE_MATCH_2}" PARENT_SCOPE)
#     set(__ans "${CMAKE_MATCH_1}" PARENT_SCOPE)
    
#     endif()
#   else()
#     set(__ans PARENT_SCOPE)
#   endif()



# endfunction()


## fasterversion
## also does not work.... 
# function(string_take_regex str_name regex)
#   if("${${str_name}}" MATCHES "^(${regex})")
#     set(__ans "${CMAKE_MATCH_1}" PARENT_SCOPE)
#     string(REGEX REPLACE "^(${regex})" "" "${str_name}" "${${str_name}}")
#     set(${str_name} "${${str_name}}" PARENT_SCOPE)    
#   else()
#     set(__ans PARENT_SCOPE)
#   endif()
# endfunction()
