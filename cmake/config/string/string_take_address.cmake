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

## `(<str_ref:<string&>>)-><str_ref:<string&>> <string>`
##
## Removes an address (regex format: ":[1-9][0-9]*") from a string reference and returns the address in "res".
## The address is also removed from the input string reference (str_ref).
##
## **Examples**
##
##
function(string_take_address str_ref)
  string_take_regex("${str_ref}" ":[1-9][0-9]*")
  ans(res)
  set(${str_ref} ${${str_ref}} PARENT_SCOPE)   
  return_ref(res)
endfunction()
