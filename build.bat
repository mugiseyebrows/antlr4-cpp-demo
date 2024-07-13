@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\mingw1120_64\bin;C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\Program Files\Meson;C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja;C:\Program Files (x86)\Android\android-sdk\cmake\3.22.1\bin;C:\Program Files\Git\cmd;C:\antlr4\mingw1120_64\bin;%PATH%
if exist "C:\Program Files\Git\mingw32\bin\curl.exe" set CURL=C:\Program Files\Git\mingw32\bin\curl.exe
if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL (
echo CURL not found
exit /b
)
if exist C:\antlr4\mingw1120_64\bin\libantlr4-runtime.dll goto antlr4runtime_end
pushd %~dp0
    if not exist antlr4 git clone https://github.com/antlr/antlr4.git
    pushd antlr4\runtime\Cpp
        if not exist "build" mkdir "build"
        pushd build
            cmake -G Ninja -D CMAKE_C_COMPILER=gcc -D CMAKE_CXX_COMPILER=g++ -D CMAKE_INSTALL_PREFIX=C:/antlr4/mingw1120_64 ..
            cmake --build . --parallel
            cmake --install .
        popd
    popd
popd
:antlr4runtime_end
if exist C:\mingw1120_64\bin\gcc.exe goto mingw1120_end
pushd %~dp0
    if not exist x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z "%CURL%" -L -o x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z https://github.com/cristianadam/mingw-builds/releases/download/v11.2.0-rev3/x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z
    7z x -y -oC:\ x86_64-11.2.0-release-posix-seh-rt_v9-rev3.7z
    move C:\mingw64 C:\mingw1120_64
popd
:mingw1120_end
if exist "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1\antlr4-4.13.1-complete.jar" goto antlr4jar_end
if not exist "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1" mkdir "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1"
pushd "%USERPROFILE%\.m2\repository\org\antlr\antlr4\4.13.1"
    "%CURL%" -L -o antlr4-4.13.1-complete.jar https://repo1.maven.org/maven2/org/antlr/antlr4/4.13.1/antlr4-4.13.1-complete.jar
popd
:antlr4jar_end
pushd %~dp0
    if not exist "build" mkdir "build"
    pushd build
        cmake -G Ninja -D CMAKE_C_COMPILER=gcc -D CMAKE_CXX_COMPILER=g++ -D CMAKE_PREFIX_PATH=C:\antlr4\mingw1120_64 ..
        cmake --build .
        main
    popd
popd