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

## `(<path>)-><qualified path>`
##
## varies the specified path until it does not exist
## this is done  by inserting a random string into the path and doing so until 
## a path is vound whic does not exist
function(path_vary path)
  path_qualify(path)
  get_filename_component(ext "${path}" EXT)
  get_filename_component(name "${path}" NAME_WE)
  get_filename_component(base "${path}" PATH)
  set(rnd)
  while(true)
    set(path "${base}/${name}${rnd}${ext}")
    
    if(NOT EXISTS "${path}")
      return("${path}")
    endif()


    ## alternatively count up
    string(RANDOM rnd)
    set(rnd "_${rnd}")

  endwhile()
endfunction()
