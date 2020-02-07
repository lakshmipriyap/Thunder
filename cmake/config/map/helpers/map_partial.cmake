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

function(test)
  new()
  ans(obj)
  obj_set(${obj} "test1" "val1")
  obj_set(${obj} "test2" "val2")
  obj_set(${obj} "test3" "val3")


  obj_pick("${obj}" test1 test3)
  ans(res)
  assert(DEREF {res.test1} STREQUAL "val1")
  assert(DEREF {res.test3} STREQUAL "val3")

  obj_pick("${obj}" test4)
  ans(res)
  assert(res)
  assert(DEREF "_{res.test4}" STREQUAL "_")


endfunction()
