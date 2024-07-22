#!/bin/bash
# This file is generated from build-on-linux.pbat, all edits will be lost
if [[ ! -e antlr4 ]]; then
    git clone https://github.com/antlr/antlr4.git
fi
pushd antlr4/runtime/Cpp
    if [[ ! -e build ]]; then
        mkdir build
    fi
    pushd build
        cmake -G Ninja -D CMAKE_BUILD_TYPE=Release ..
        cmake --build . --parallel
        sudo cmake --install .
    popd
popd
if [[ ! -e ~/.m2/repository/org/antlr/antlr4/4.13.1 ]]; then
    mkdir ~/.m2/repository/org/antlr/antlr4/4.13.1
fi
if [[ ! -e ~/.m2/repository/org/antlr/antlr4/4.13.1/antlr4-4.13.1-complete.jar ]]; then
    curl -L -o ~/.m2/repository/org/antlr/antlr4/4.13.1/antlr4-4.13.1-complete.jar https://repo1.maven.org/maven2/org/antlr/antlr4/4.13.1/antlr4-4.13.1-complete.jar
fi
if [[ ! -e build ]]; then
    mkdir build
fi
pushd build
    cmake -G Ninja -D CMAKE_BUILD_TYPE=Release ..
    cmake --build . --parallel
popd
build/main