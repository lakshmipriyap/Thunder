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

## `(<~event> <args:<any...>>)-><any...>`
##
## emits the specified event. goes throug all event handlers registered to
## this event and 
## if event handlers are added during an event they will be called as well
##
## if a event calls event_cancel() 
## all further event handlers are disregarded
##
## returns the accumulated result of the single event handlers
function(event_emit event)
  is_event("${event}")
  ans(is_event)
  
  if(NOT is_event)
    event_get("${event}")
    ans(event)
  endif()


  if(NOT event)
    return()
  endif()


  set(result)

  set(previous_handlers)
  # loop aslong as new event handlers are appearing
  # 
  address_new()
  ans(__current_event_cancel)
  address_set(${__current_event_cancel} false)
  while(true)
    ## 
    map_tryget(${event} handlers)
    ans(handlers)
    list_remove(handlers ${previous_handlers} "")
    list(APPEND previous_handlers ${handlers})

    list_length(handlers)
    ans(length)
    if(NOT "${length}" GREATER 0) 
      break()
    endif()

    foreach(handler ${handlers})

      event_handler_call(${event} ${handler} ${ARGN})
      ans(success)
      list(APPEND result "${success}")
      ## check if cancel is requested
      address_get(${__current_event_cancel})
      ans(break)
      if(break)
        return_ref(result)
      endif()
    endforeach()
  endwhile()

  return_ref(result)
endfunction() 
