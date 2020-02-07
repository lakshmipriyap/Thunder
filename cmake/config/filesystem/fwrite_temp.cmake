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

## 
## 
## creates a temporary file containing the specified content
## returns the path for that file 
function(fwrite_temp content)
  set(ext ${ARGN})

  if(NOT ext)
    set(ext ".txt")
  endif()

  #cmakepp_config(temp_dir)
  #ans(temp_dir)
  set(temp_dir "/tmp")

  path_vary("${temp_dir}/fwrite_temp${ext}")
  ans(temp_path)

  fwrite("${temp_path}" "${content}")

  return_ref(temp_path)

endfunction()
