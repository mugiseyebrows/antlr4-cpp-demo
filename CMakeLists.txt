cmake_minimum_required(VERSION 3.22)
project(antlr-demo)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

find_package(AntlrRuntime)

antlr_generate(LEXER TLexer PARSER TParser NAMESPACE antlrcpptest OUT generated)

add_executable(main ${generated} main.cpp)

target_include_directories(main PRIVATE ${CMAKE_CURRENT_BINARY_DIR} ${ANTLR_RUNTIME_INCLUDE_DIR})

target_link_libraries(main PRIVATE ${ANTLR_RUNTIME_LIB})
