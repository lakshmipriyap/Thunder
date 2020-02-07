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

# special chars |||||||↔|†|‡
macro(string_codes)
  string(ASCII 14 "${ARGN}free_token1")
  string(ASCII 15 "${ARGN}free_token2")
  string(ASCII 1 "${ARGN}free_token3")
  string(ASCII 2 "${ARGN}free_token4")

  string(ASCII 29 "${ARGN}bracket_open_code")
  string(ASCII 28 "${ARGN}bracket_close_code")
  string(ASCII 30 "${ARGN}ref_token")
  string(ASCII 21 "${ARGN}free_token")
  string(ASCII 31 "${ARGN}semicolon_code")
  string(ASCII 24 "${ARGN}empty_code")
  string(ASCII 2  "${ARGN}paren_open_code")
  string(ASCII 3  "${ARGN}paren_close_code")
  set("${ARGN}identifier_token" "__")
endmacro()

function(string_codes_print)
  string_codes()
  print_vars(--plain "bracket_open_code")
  print_vars(--plain "bracket_close_code")
  print_vars(--plain "ref_token")
  print_vars(--plain "semicolon_code")
  print_vars(--plain "empty_code")
  print_vars(--plain "paren_open_code")
  print_vars(--plain "paren_close_code")
  print_vars(--plain "free_token")
  print_vars(--plain "free_token1")
  print_vars(--plain "free_token2")
  print_vars(--plain "free_token3")
  print_vars(--plain "free_token4")
endfunction()
