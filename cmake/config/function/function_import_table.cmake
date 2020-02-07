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

# imports the specified map as a function table which is callable via <function_name>
# whis is a performance enhancement 
function(function_import_table map function_name)
  map_keys(${map} )
  ans(keys)
  set("ifs" "if(false)\n")
  foreach(key ${keys})
    map_get(${map}  ${key})
    ans(command_name)
    set(ifs "${ifs}elseif(\"${key}\" STREQUAL \"\${switch}\" )\n${command_name}(\"\${ARGN}\")\nreturn_ans()\n")
  endforeach()
  set(ifs "${ifs}endif()\n")
set("evl" "function(${function_name} switch)\n${ifs}\nreturn()\nendfunction()")
   # message(${evl})
  set_ans("")
   
    eval("${evl}")
endfunction()

