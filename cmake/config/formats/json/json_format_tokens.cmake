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

function(json_format_tokens result tokens)
	set(spacing "  ")
	set(level 0)
	set(indentation "")
	macro(set_indent)
		set(indentation)
		if("${level}" GREATER 0)
		math(EXPR range "${level} - 1")
		foreach(i RANGE "${range}")
			set(indentation "${indentation}${spacing}")
		endforeach()
		endif()
	endmacro()
	macro(increase_indent)
		math(EXPR level "${level} + 1")
		set_indent()
	endmacro()


	macro(decrease_indent)
		math(EXPR level "${level} - 1")
		set_indent()
	endmacro()
	set_indent()

	set(indented "${indentation}")
	foreach(token ${tokens})		
		if("${token}" STREQUAL "{")
			increase_indent()
			set(indented "${indented}{\n${indentation}")
		elseif("${token}" STREQUAL "<")
			increase_indent()
			set(indented "${indented}[\n${indentation}")
		elseif("${token}" STREQUAL ",")
			set(indented "${indented},\n${indentation}")
		elseif("${token}" STREQUAL "}")
			decrease_indent()
			set(indented "${indented}\n${indentation}}")
		elseif("${token}" STREQUAL ">")
			decrease_indent()
			set(indented "${indented}\n${indentation}]")
		elseif("${token}" STREQUAL ":")
			set(indented "${indented} : ")
		else()
			if(NOT  "${token}" MATCHES "^\".*")
				set(indented "${indented};")
			endif()

			json_escape( "${token}")
			ans(token)
			set(indented "${indented}${token}")
		endif()



	endforeach()
	return_value("${indented}")
endfunction()
