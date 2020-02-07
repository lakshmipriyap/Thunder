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

function(is_address ref)
  list(LENGTH ref len)
  if(NOT ${len} EQUAL 1)
    return(false)
  endif()
	string(REGEX MATCH "^:" res "${ref}" )
	if(res)
		return(true)
	endif()
	return(false)
endfunction()

## faster - does not work in all cases
macro(is_address ref)
  if("_${ref}" MATCHES "^_:[^;]+$")
    set(__ans true)
  else()  
    set(__ans false)
  endif()
endmacro()


## correcter
## the version above cannot be used because 
## is_address gets arbirtray data - and since macros evaluate 
## arguments a invalid ref could be ssen as valid 
## or especially \\ fails because it beomes \ and causes an error
function(is_address ref)
  if("_${ref}" MATCHES "^_:[^;]+$")
    set(__ans true PARENT_SCOPE)
  else()  
    set(__ans false PARENT_SCOPE)
  endif()
endfunction()
