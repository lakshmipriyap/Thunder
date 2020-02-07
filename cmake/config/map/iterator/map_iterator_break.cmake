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

# use this macro inside of a while(true) loop it breaks when the iterator is over
# e.g. this prints all key values in the map
# while(true) 
#   map_iterator_break(myiterator)
#   message("${myiterator.key} = ${myiterator.value}")
# endwhile()
macro(map_iterator_break it_ref)
  map_iterator_next(${it_ref})
  if("${it_ref}.end")
    break()
  endif()
endmacro()
