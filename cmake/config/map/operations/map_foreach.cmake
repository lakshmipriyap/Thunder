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

# executes action (key, value)->void
# on every key value pair in map
# exmpl: map = {id:'1',val:'3'}
# map_foreach("${map}" "(k,v)-> message($k $v)")
# prints 
#  id;1
#  val;3
function(map_foreach map action)
	map_keys("${map}")
	ans(keys)
	foreach(key ${keys})
		map_tryget("${map}" "${key}")
		ans(val)
		call("${action}"("${key}" "${val}"))
	endforeach()
endfunction()
