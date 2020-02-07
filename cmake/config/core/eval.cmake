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

# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
# eval will not modify ans (the code evaluated may modify ans)
# vars starting with __eval should not be used in code
function(eval __eval_code)
  
  # one file per execution of cmake (if this file were in memory it would probably be faster...)
  fwrite_temp("" ".cmake")
  ans(__eval_temp_file)


# speedup: statically write filename so eval boils down to 3 function calls
 file(WRITE "${__eval_temp_file}" "
function(eval __eval_code)
  file(WRITE ${__eval_temp_file} \"\${__eval_code}\")
  include(${__eval_temp_file})
  set(__ans \${__ans} PARENT_SCOPE)
endfunction()
  ")
include("${__eval_temp_file}")


eval("${__eval_code}")
return_ans()
endfunction()


