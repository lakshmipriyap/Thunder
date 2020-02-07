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

## `(<base_dir:<qualified path>> <~path>) -> <qualified path>`
##
## @todo realpath or abspath?
## qualfies a path using the specified base_dir
##
## if path is absolute (starts with / or under windows with <drive letter>:/) 
## it is returned as is
##
## if path starts with a '~' (tilde) the path is 
## qualfied by prepending the current home directory (on all OSs)
##
## is neither absolute nor starts with ~
## the path is relative and it is qualified 
## by prepending the specified <base dir>
function(path_qualify_from base_dir path)
  string(REPLACE \\ / path "${path}")
  get_filename_component(realpath "${path}" ABSOLUTE)
  
  ## windows absolute path
  if(WIN32 AND "_${path}" MATCHES "^_[a-zA-Z]:\\/")
    return_ref(realpath)
  endif()
   
   ## posix absolute path
  if("_${path}" MATCHES "^_\\/")
    return_ref(realpath)
  endif()


  ## home path
  if("_${path}" MATCHES "^_~\\/?(.*)")
    home_dir()
    ans(base_dir)
    set(path "${CMAKE_MATCH_1}")
  endif()

  set(path "${base_dir}/${path}")

  ## relative path
  get_filename_component(realpath "${path}" ABSOLUTE)
  
  return_ref(realpath)
endfunction()
