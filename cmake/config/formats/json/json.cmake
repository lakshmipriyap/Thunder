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

function(json)
# define callbacks for building result
  function(json_obj_begin)
    map_append_string(${context} json "{")
  endfunction()
  function(json_obj_end)
    map_append_string(${context} json "}")
  endfunction()
  function(json_array_begin)
    map_append_string(${context} json "[")
  endfunction()
  function(json_array_end)
    map_append_string(${context} json "]")
  endfunction()
  function(json_obj_keyvalue_begin)
    cmake_string_to_json("${map_element_key}")
    ans(map_element_key)
    map_append_string(${context} json "${map_element_key}:")
  endfunction()

  function(json_obj_keyvalue_end)
    math(EXPR comma "${map_length} - ${map_element_index} -1 ")
    if(comma)
      map_append_string(${context} json ",")
    endif()
  endfunction()

  function(json_array_element_end)
    math(EXPR comma "${list_length} - ${list_element_index} -1 ")
    if(comma)
      map_append_string(${context} json ",")
    endif()
  endfunction()
  function(json_literal)
    if(NOT content_length)
      map_append_string(${context} json "null")
    elseif("_${node}" MATCHES "^_((([1-9][0-9]*)([.][0-9]+([eE][+-]?[0-9]+)?)?)|true|false)$")
      map_append_string(${context} json "${node}")
    else()
      cmake_string_to_json("${node}")
      ans(node)
      map_append_string(${context} json "${node}")
    endif()
    return()

  endfunction()

   map()
    kv(value              json_literal)
    kv(map_begin          json_obj_begin)
    kv(map_end            json_obj_end)
    kv(list_begin         json_array_begin)
    kv(list_end           json_array_end)
    kv(map_element_begin  json_obj_keyvalue_begin)
    kv(map_element_end    json_obj_keyvalue_end)
    kv(list_element_end   json_array_element_end)
  end()
  ans(json_cbs)
  function_import_table(${json_cbs} json_callback)

  # function definition
  function(json)        
    map_new()
    ans(context)
    dfs_callback(json_callback ${ARGN})
    map_tryget(${context} json)
    return_ans()  
  endfunction()
  #delegate
  json(${ARGN})
  return_ans()
endfunction()
