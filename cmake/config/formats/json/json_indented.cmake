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

function(json_indented)
  # define callbacks for building result
  function(json_obj_begin_indented)
    #message(PUSH_AFTER "json_obj_begin_indented(${ARGN})")
    map_tryget(${context} indentation)
    ans(indentation)
    map_append_string(${context} json "{\n")
    map_append_string(${context} indentation " ")
  endfunction()

  function(json_obj_end_indented)
    #message(POP "json_obj_end_indented(${ARGN})")
    map_tryget(${context} indentation)
    ans(indentation)
    string(SUBSTRING "${indentation}" 1 -1 indentation)
    map_set(${context} indentation "${indentation}")
    map_append_string(${context} json "${indentation}}")

  endfunction()
  function(json_array_begin_indented)
    #message(PUSH_AFTER "json_array_begin_indented(${ARGN}) ${context}")
    map_tryget(${context} indentation)
    ans(indentation)
    map_append_string(${context} json "[\n")
    map_append_string(${context} indentation " ")
  endfunction()

  function(json_array_end_indented)
    #message(POP "json_array_end_indented(${ARGN}) ${context}")
    map_tryget(${context} indentation)
    ans(indentation)
    string(SUBSTRING "${indentation}" 1 -1 indentation)
    map_set(${context} indentation "${indentation}")
    map_append_string(${context} json "${indentation}]")
  endfunction()

  function(json_obj_keyvalue_begin_indented)
    #message("json_obj_keyvalue_begin_indented(${key} ${ARGN}) ${context}")
    map_tryget(${context} indentation)
    ans(indentation)
    map_append_string(${context} json "${indentation}\"${map_element_key}\":")
  endfunction()

  function(json_obj_keyvalue_end_indented)
    #message("json_obj_keyvalue_end_indented(${ARGN}) ${context}")
    math(EXPR comma "${map_length} - ${map_element_index} -1 ")
    if(comma)
      map_append_string(${context} json ",")
    endif()
    map_append_string(${context} json "\n")
  endfunction()

  function(json_array_element_begin_indented)
    if (NOT "${list_element}" STREQUAL "___array___")
      #message("json_array_element_begin_indented(${ARGN}) ${context}")
      map_tryget(${context} indentation)
      ans(indentation)
      map_append_string(${context} json "${indentation}")
    endif()
  endfunction()

  function(json_array_element_end_indented)
    #message("json_array_element_end_indented(${ARGN}) ${context}")
    if (NOT "${list_element}" STREQUAL "___array___")
      math(EXPR comma "${list_length} - ${list_element_index} -1 ")
      if(comma)
        map_append_string(${context} json ",")
      endif()
      map_append_string(${context} json "\n")
    endif()
  endfunction()

  function(json_literal_indented)
    if (NOT "${node}" STREQUAL "___array___")
        if(NOT content_length)
          map_append_string(${context} json "null")
        elseif("_${node}" MATCHES "^_(0|(([1-9][0-9]*)([.][0-9]+([eE][+-]?[0-9]+)?)?)|(true)|(false))$")
          map_append_string(${context} json "${node}")
        else()
          cmake_string_to_json("${node}")
          ans(node)
          map_append_string(${context} json "${node}")
        endif()
    endif()
    return()
  endfunction()

   map()
    kv(value              json_literal_indented)
    kv(map_begin          json_obj_begin_indented)
    kv(map_end            json_obj_end_indented)
    kv(list_begin         json_array_begin_indented)
    kv(list_end           json_array_end_indented)
    kv(map_element_begin  json_obj_keyvalue_begin_indented)
    kv(map_element_end    json_obj_keyvalue_end_indented)
    kv(list_element_begin json_array_element_begin_indented)
    kv(list_element_end   json_array_element_end_indented)
  end()
  ans(json_cbs)
  function_import_table(${json_cbs} json_indented_callback)

  # function definition
  function(json_indented)        
    map_new()
    ans(context)
    dfs_callback(json_indented_callback ${ARGN})
    map_tryget(${context} json)
    return_ans()  
  endfunction()
  #delegate
  json_indented(${ARGN})
  return_ans()
endfunction()
