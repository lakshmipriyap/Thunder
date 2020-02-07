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

  ## files non existing or null values of lhs with values of rhs
  function(map_fill lhs rhs)
    map_ensure(lhs rhs)
    map_iterator(${rhs})
    ans(it)
    while(true)
      map_iterator_break(it)
    
      map_tryget(${lhs} "${it.key}")
      ans(lvalue)

      if("${lvalue}_" STREQUAL "_")
        map_set(${lhs} "${it.key}" "${it.value}")
      endif()
    endwhile()
    return_ref(lhs)
  endfunction()
