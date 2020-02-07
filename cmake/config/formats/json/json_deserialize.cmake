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

## `(<json code>)->{}`
##
## deserializes the specified json code. In combination with json there are a few things
## that need mention:
## * semicolons.  If you use semicolons in json then they will be deserialized as
##   ASCII 31 (Unit Separator) which allows cmake to know the difference to the semicolons in a list
##   if you want semicolons to appear in cmake then use a json array. You can always use `string_decode_semicolon()`
##   to obtain the string as it was in json
##   eg. `[1,2,3] => 1;2;3`  `"1;2;3" => 1${semicolon_code}2${semicolon_code}3`
## 
function(json_deserialize json)
  json4("${json}")
  return_ans()
endfunction()
