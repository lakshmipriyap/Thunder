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

function(cmake_string_to_json str)
  string_decode_semicolon("${str}")
  ans(str)
  string(REPLACE "\\" "\\\\" str "${str}")
  string(REPLACE "\"" "\\\"" str "${str}")
  string(REPLACE "\n" "\\n" str "${str}")
  string(REPLACE "\t" "\\t" str "${str}")
  string(REPLACE "\t" "\\t" str "${str}")
  string(REPLACE "\r" "\\r" str "${str}")
  string(ASCII 8 bs)
  string(REPLACE "${bs}" "\\b" str "${str}")
  string(ASCII 12 ff)
  string(REPLACE "${ff}" "\\f" str "${str}")
  string(REPLACE ";" "\\\\;" str "${str}")
  set(str "\"${str}\"")
  return_ref(str)
endfunction()
