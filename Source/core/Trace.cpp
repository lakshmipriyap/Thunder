 /*
 * If not stated otherwise in this file or this component's LICENSE file the
 * following copyright and licenses apply:
 *
 * Copyright 2020 RDK Management
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
#include <sstream>

#include "Sync.h"
#include "TextFragment.h"
#include "Trace.h"

namespace WPEFramework {
namespace Core {
    class Demangling {
    private:
        Demangling(const Demangling&);
        Demangling& operator=(const Demangling&);

    public:
        Demangling()
            : _processLock()
            , _allocatedSize(512)
            , _allocationName(static_cast<char*>(malloc(_allocatedSize)))
        {
        }
        ~Demangling()
        {
            if (_allocationName != nullptr) {
                free(_allocationName);
            }
        }

        inline TextFragment Demangled(const char name[])
        {
            _processLock.Lock();

#ifdef __LINUX__
            int status;
            char* demangledName = abi::__cxa_demangle(name, _allocationName, &_allocatedSize, &status);

            // Check for, and deal with, error.
            if (demangledName == nullptr) {
                strncpy(_allocationName, name, _allocatedSize);
            } else {
                _allocationName = demangledName;
            }

            std::string newName(_allocationName);
#endif

#ifdef __WINDOWS__
            uint16_t index = 0;
            uint16_t moveTo = 0;
            while ((name[index] != '\0') && (moveTo < (_allocatedSize - 1))) {
                if ((name[index] == 'c') && (name[index + 1] == 'l') && (name[index + 2] == 'a') && (name[index + 3] == 's') && (name[index + 4] == 's') && (name[index + 5] == ' ')) {
                    // we need to skip class :-)
                    index += 6;
                } else if ((name[index] == 's') && (name[index + 1] == 't') && (name[index + 2] == 'r') && (name[index + 3] == 'u') && (name[index + 4] == 'c') && (name[index + 5] == 't') && (name[index + 6] == ' ')) {
                    // We need to skip struct
                    index += 7;
                } else if ((name[index] == 'e') && (name[index + 1] == 'n') && (name[index + 2] == 'u') && (name[index + 3] == 'm') && (name[index + 4] == ' ')) {
                    // We need to skip enum
                    index += 5;
                } else {
                    _allocationName[moveTo++] = name[index++];
                }
            }
            _allocationName[moveTo++] = '\0';
            std::string newName(_allocationName, moveTo);
#endif

            _processLock.Unlock();

            return (TextFragment(newName));
        }

        inline TextFragment ClassName(const char name[])
        {
            TextFragment result(Demangled(name));
            uint16_t index = 0;
            uint16_t lastIndex = static_cast<uint16_t>(~0);

            while ((index < result.Length()) && (result[index] != '<')) {
                if (result[index] == ':') {
                    lastIndex = index;
                }
                index++;
            }

            return (lastIndex < (index - 1) ? TextFragment(result, lastIndex + 1, result.Length() - (lastIndex + 1)) : result);
        }

    private:
        CriticalSection _processLock;
        size_t _allocatedSize;
        char* _allocationName;
    };

    static Demangling demangleClassNames;

    TextFragment ClassNameOnly(const char className[])
    {
        return (demangleClassNames.ClassName(className));
    }

    const char* FileNameOnly(const char fileName[])
    {
        uint16_t index = static_cast<uint16_t>(strlen(fileName));
        bool found = false;

        if (index > 0) {
            do {
                index--;

                found = ((fileName[index] == '\\') || (fileName[index] == '/'));

            } while ((found == false) && (index != 0));
        }

        return (found == false ? fileName : &fileName[index + 1]);
    }

    string LogMessage(const TCHAR fileName[], const uint32_t lineNumber, const TCHAR* message)
    {
#ifdef _UNICODE
        std::wstringstream ss;
#else
        std::stringstream ss;
#endif

        ss << _T("[") << fileName << _T(":") << lineNumber << _T("]  == ") << message;

        return (ss.str());
    }
}
} // namespace Core
