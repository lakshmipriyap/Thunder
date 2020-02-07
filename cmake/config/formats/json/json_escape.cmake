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

# function to escape json
function(json_escape value)
	string(REGEX REPLACE "\\\\" "\\\\\\\\" value "${value}")
	string(REGEX REPLACE "\\\"" "\\\\\"" value "${value}")
	string(REGEX REPLACE "\n" "\\\\n" value "${value}")
	string(REGEX REPLACE "\r" "\\\\r" value "${value}")
	string(REGEX REPLACE "\t" "\\\\t" value "${value}")
	string(REGEX REPLACE "\\$" "\\\\$" value "${value}")	
	string(REGEX REPLACE ";" "\\\\\\\\;" value "${value}")
	return_ref(value)
endfunction()
