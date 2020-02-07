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

# reads a json file from the specified location
# the location may be relative (see explanantion of path() function)
# returns a map or nothing if reading fails 
function(json_read file)
    path("${file}")
    ans(file)
    if(NOT EXISTS "${file}")
      return()
    endif()
    checksum_file("${file}")
    ans(cache_key)
    file_cache_return_hit("${cache_key}")

    file(READ "${file}" data)
    json_deserialize("${data}")
    ans(data)

    file_cache_update("${cache_key}" "${data}")

    return_ref(data)
endfunction()
