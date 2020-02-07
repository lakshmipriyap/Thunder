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

# removes the last element from list and returns it
function(list_pop_back __list_pop_back_lst)

  if("${${__list_pop_back_lst}}_" STREQUAL "_")
    return()
  endif()
  list(LENGTH "${__list_pop_back_lst}" len)
  math(EXPR len "${len} - 1")
  list(GET "${__list_pop_back_lst}" "${len}" res)
  list(REMOVE_AT "${__list_pop_back_lst}" ${len})
  set("${__list_pop_back_lst}" ${${__list_pop_back_lst}} PARENT_SCOPE)
  return_ref(res)
endfunction()



  # removes the last element from list and returns it
  ## faster version
macro(list_pop_back __list_pop_back_lst)
  if("${${__list_pop_back_lst}}_" STREQUAL "_")
    set(__ans)
  else()
    list(LENGTH "${__list_pop_back_lst}" __list_pop_back_length)
    math(EXPR __list_pop_back_length "${__list_pop_back_length} - 1")
    list(GET "${__list_pop_back_lst}" "${__list_pop_back_length}" __ans)
    list(REMOVE_AT "${__list_pop_back_lst}" ${__list_pop_back_length})
  endif()
endmacro()
