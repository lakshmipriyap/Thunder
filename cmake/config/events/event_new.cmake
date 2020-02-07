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

## `(<?event-id>)-><event>`
##
## creates an registers a new event which is identified by
## `<event-id>` if the id is not specified a unique id is generated
## and used.
## 
## returns a new <event> object: 
## {
##   event_id:<event-id>
##   handlers: <callable...> 
##   ... (psibbly cancellable, aggregations)
## }
## also defines a global function called `<event-id>` which can be used to emit the event
##
function(event_new)
  set(event_id ${ARGN})
  if(NOT event_id)
    identifier(event)
    ans(event_id)
  endif()

  if(COMMAND ${event_id})
    message(FATAL_ERROR "specified event already exists")
  endif()

  ## curry the event emit function and create a callable from the event
  curry3(${event_id}() => event_emit("${event_id}" /*))
  ans(event)

  callable("${event}")
  ans(event)  


  curry3(() => event_addhandler("${event_id}" /*))
  ans(add_handler)

  curry3(() => event_removehandler("${event_id}" /*))
  ans(remove_handler)

  curry3(() => event_clear("${event_id}" /*))
  ans(clear)



  ## set event's properties
  map_set(${event} event_id "${event_id}")
  map_set(${event} handlers)
  map_set(${event} add ${add_handler})
  map_set(${event} remove ${remove_handler})
  map_set(${event} clear ${clear})

  ## register event globally
  events()
  ans(events)
  map_set(${events} "${event_id}" ${event})

  return(${event})  
endfunction()

## faster version (does not use curry but a custom implementation)
function(event_new)
  set(event_id ${ARGN})
  if(NOT event_id)
    identifier(event)
    ans(event_id)
  endif()

  if(COMMAND ${event_id})
    message(FATAL_ERROR "specified event already exists")
  endif()

  ## curry the event emit function and create a callable from the event

  function_new()
  ans(add_handler)
  function_new()
  ans(remove_handler)
  function_new()
  ans(clear)
  eval("
    function(${event_id})
      event_emit(\"${event_id}\" \${ARGN})
      return_ans()
    endfunction()
    function(${add_handler})
      event_addhandler(\"${event_id}\" \${ARGN})
      return_ans()
    endfunction()
    function(${remove_handler})
      event_removehandler(\"${event_id}\" \${ARGN})
      return_ans()
    endfunction()
    function(${clear})
      event_clear(\"${event_id}\" \${ARGN})
      return_ans()
    endfunction()

  ")

  callable("${event_id}")
  ans(event)  

  ## set event's properties
  map_set(${event} event_id "${event_id}")
  map_set(${event} handlers)
  map_set(${event} add ${add_handler})
  map_set(${event} remove ${remove_handler})
  map_set(${event} clear ${clear})

  ## register event globally
  events()
  ans(events)
  map_set(${events} "${event_id}" ${event})

  return(${event})  
endfunction()



