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

  ## quickly extracts string properties values from a json string
  ## useful for large json files with unique property keys
  function(json_extract_string_value key data)
    regex_escaped_string("\"" "\"") 
    ans(regex)

    set(key_value_regex "\"${key}\" *: ${regex}")
    string(REGEX MATCHALL  "${key_value_regex}" matches "${data}")
    set(values)
    foreach(match ${matches})
      string(REGEX REPLACE "${key_value_regex}" "\\1" match "${match}")
      list(APPEND values "${match}")
    endforeach() 
    return_ref(values)
  endfunction()
