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

function(json_tokenize result json)

	set(regex "(\\{|\\}|:|,|\\[|\\]|\"(\\\\.|[^\"])*\")")
	string(REGEX MATCHALL "${regex}" matches "${json}")


	# replace brackets with angular brackets because
	# normal brackes are not handled properly by cmake
	string(REPLACE  ";[;" ";<;" matches "${matches}")
	string(REPLACE ";];" ";>;" matches "${matches}")
	string(REPLACE "[" "†" matches "${matches}")
	string(REPLACE "]" "‡" matches "${matches}")

	set(tokens)
	foreach(match ${matches})
		string_char_at("${match}" 0)
		ans(char)
		if("${char}" STREQUAL "[")
			string_char_at("${match}" -2)
			ans(char)
			if(NOT "${char}" STREQUAL "]")
				message(FATAL_ERROR "json syntax error: no closing ']' instead: '${char}' ")
			endif()
			string(LENGTH "${match}" len)
			math(EXPR len "${len} - 2")
			string(SUBSTRING ${match} 1 ${len} array_values)
			set(tokens ${tokens} "<")
			foreach(submatch ${array_values})
				set(tokens ${tokens} ${submatch} )
			endforeach()
			set(tokens ${tokens} ">")
		else()
			set(tokens ${tokens} ${match})
		endif()
	endforeach()

	set(${result} ${tokens} PARENT_SCOPE)
endfunction()
