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

  ## unpacks the specified reference to a map
  ## let a map be stored in the var 'themap'
  ## let it have the key/values a/1 b/2 c/3
  ## map_unpack(themap) will create the variables
  ## ${themap.a} contains 1
  ## ${themap.b} contains 2
  ## ${themap.c} contains 3
  function(map_unpack __ref)
    map_iterator(${${__ref}})
    ans(it)
    while(true)
      map_iterator_break(it)
      set("${__ref}.${it.key}" ${it.value} PARENT_SCOPE)
    endwhile()
  endfunction()
