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

## `(<event-id...>)-><event tracker>`
##
## sets up a function which listens only to the specified events
## 
function(events_track)
  function_new()
  ans(function_name)

  map_new()
  ans(map)

  eval("
    function(${function_name})
      map_new()
      ans(event_args)
      map_tryget(\${event} event_id)
      ans(event_id)
      map_set(\${event_args} id \${event_id})
      map_set(\${event_args} args \${ARGN})
      map_set(\${event_args} event \${event})
      map_append(${map} \${event_id} \${event_args})
      map_append(${map} event_ids \${event_id})
      return(\${event_args})
    endfunction()
  ")

  foreach(event ${ARGN})
    event_addhandler(${event} ${function_name})
  endforeach()

  return(${map})
endfunction()
