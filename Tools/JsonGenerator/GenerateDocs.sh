#!/bin/bash

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

#
# Generates Plugin Markdown documentation.
#
# Example:
#   ./GenerateDocs ../../../WPEFrameworkPlugins/Streamer/StreamerPlugin.json
#   ./GenerateDocs ../../../WPEFrameworkPlugins/Streamer/StreamerPlugin.json ../../../WPEFrameworkPlugins/TimeSync/TimeSyncPlugin.json
#   ./GenerateDocs -d ../../../WPEFrameworkPlugins
#

command -v ./JsonGenerator.py >/dev/null 2>&1 || { echo >&2 "JsonGenerator.py is not available. Aborting."; exit 1; }

if [ "$1" = "-d" ]; then
   files=`find $2 -name "*Plugin.json"`
elif [ $# -gt 0 ]; then
   files=$@
else
   echo >&2 "usage: $0 [-d <directory>|<json> ...]"
   exit 0
fi

echo "Generating Plugin markdown documentation..."

./JsonGenerator.py --docs -i ../../Source/interfaces/json $files -o doc

echo "Done."
