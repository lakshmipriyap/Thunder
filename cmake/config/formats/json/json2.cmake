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

function(json2 input)
  
  json2_definition()
  ans(lang)
  language_initialize(${lang})
  address_set(json2_language_definition "${lang}")
  function(json2 input) 
    checksum_string("${input}")   
    ans(ck)
    file_cache_return_hit("${ck}")
    address_get(json2_language_definition)
    ans(lang)
    map_new()
    ans(ctx)
    map_set(${ctx} input "${input}")
    map_set(${ctx} def "json")
    obj_setprototype(${ctx} "${lang}")

    #lang2(output json2 input "${input}" def "json")

    lang(output ${ctx})
    ans(res)
    file_cache_update("${ck}" ${res})
    return_ref(res)
  endfunction()
  json2("${input}")
  return_ans()
endfunction()
