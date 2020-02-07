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

## `(<any>...)-><bool>`
##
## returns true iff the specified value is a map
## note to self: cannot make this a macro because string will be evaluated
function(is_map)
	get_property(is_map GLOBAL PROPERTY "${ARGN}.__keys__" SET)
	set(__ans "${is_map}" PARENT_SCOPE)
endfunction()
