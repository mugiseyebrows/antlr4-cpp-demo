@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\mingw64\bin;C:\mingw1220_64\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\mingw32\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Meson;C:\Program Files\Git\cmd;C:\antlr4\mingw1220_64\bin;%PATH%
:: mingw64 12.2.0 installed in C:\mingw64
gcc -v
if exist C:\mingw1220_64\bin\gcc.exe goto mingw1220_end
if exist C:\mingw64\bin\gcc.exe goto mingw1220_end
if not exist x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z curl -L -o x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z https://github.com/cristianadam/mingw-builds/releases/download/v11.2.0-rev3/x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z
7z x -y -oC:\ x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z
move C:\mingw64 C:\mingw1220_64
:mingw1220_end
if exist C:\antlr4\mingw1220_64\bin\libantlr4-runtime.dll goto antlr4runtime_end
if not exist antlr4 git clone https://github.com/antlr/antlr4.git
pushd antlr4\runtime\Cpp
    if not exist build mkdir build
    pushd build
        cmake -G Ninja -D CMAKE_C_COMPILER=gcc -D CMAKE_CXX_COMPILER=g++ -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=C:/antlr4/mingw1220_64 ..
        cmake --build . --parallel
        cmake --install .
    popd
popd
:antlr4runtime_end
if not exist "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1" mkdir "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1"
if not exist "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1\antlr4-4.13.1-complete.jar" curl -L -o "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1\antlr4-4.13.1-complete.jar" https://repo1.maven.org/maven2/org/antlr/antlr4/4.13.1/antlr4-4.13.1-complete.jar
if not exist build mkdir build
pushd build
    cmake -G Ninja -D CMAKE_C_COMPILER=gcc -D CMAKE_CXX_COMPILER=g++ -D CMAKE_BUILD_TYPE=Release -D CMAKE_PREFIX_PATH=C:/antlr4/mingw1220_64 ..
    cmake --build . --parallel
popd
build\main