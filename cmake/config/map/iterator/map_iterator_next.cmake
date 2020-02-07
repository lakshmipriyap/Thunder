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

## this function moves the map iterator to the next position
## and returns true if it was possible
## e.g.
## map_iterator_next(myiterator) 
## ans(ok) ## is true if iterator had a next element
## variables ${myiterator.key} and ${myiterator.value} are available
macro(map_iterator_next it_ref)
  list(LENGTH "${it_ref}" __map_iterator_next_length)
  if("${__map_iterator_next_length}" GREATER 1)
    list(REMOVE_AT "${it_ref}" 1)
    if(NOT "${__map_iterator_next_length}" EQUAL 2)
      list(GET "${it_ref}" 1 "${it_ref}.key")
      list(GET "${it_ref}" 0 "__map_iterator_map")
      get_property("${it_ref}.value" GLOBAL PROPERTY "${__map_iterator_map}.${${it_ref}.key}")
      set(__ans true)
    else()
      set(__ans false)
      set("${it_ref}.end" true)
    endif() 
  else()
    set("${it_ref}.end" true)
    set(__ans false)
  endif()
endmacro()
