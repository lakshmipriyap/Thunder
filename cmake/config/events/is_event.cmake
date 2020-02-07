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

## `(<any>)-><bool>`
##
## returns true if the specified value is an event
## an event is a ref which is callable and has an event_id
##
function(is_event event)
  is_address("${event}")
  ans(is_ref)
  if(NOT is_ref)
    return()
  endif()
  is_callable("${event}")
  ans(is_callable)
  if(NOT is_callable)
    return(false)
  endif()

  map_has(${event} event_id)
  ans(has_event_id)
  if(NOT has_event_id)
    return(false)
  endif()

  return(true)
endfunction()
