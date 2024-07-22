find_library(ANTLR_RUNTIME_LIB NAMES antlr4-runtime PATH_SUFFIXES lib)
find_path(ANTLR_RUNTIME_INCLUDE_DIR antlr4-runtime.h PATH_SUFFIXES include/antlr4-runtime)

# pip install antlr4-tools
# antlr4

if (WIN32)
    file(GLOB ANTLR_JARS "$ENV{USERPROFILE}/.m2/repository/org/antlr/antlr4/4.*/antlr4-4.*-complete.jar")
else()
    file(GLOB ANTLR_JARS "$ENV{HOME}/.m2/repository/org/antlr/antlr4/4.*/antlr4-4.*-complete.jar")
endif()
if(ANTLR_JARS)
    list(GET ANTLR_JARS -1 ANTLR_JAR)
endif()

find_package(Java)

function(antlr_generate)
    set(options LISTENER VISITOR)
    set(oneValueArgs LEXER PARSER NAMESPACE)
    set(multiValueArgs)
    cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    set(cmd_args -jar ${ANTLR_JAR} -o . -Dlanguage=Cpp -package ${ARG_NAMESPACE} "${CMAKE_CURRENT_SOURCE_DIR}/${ARG_LEXER}.g4" "${CMAKE_CURRENT_SOURCE_DIR}/${ARG_PARSER}.g4")
    if (ARG_LISTENER)
        list(APPEND cmd_args -listener)
    else()
        list(APPEND cmd_args -no-listener)
    endif()
    if (ARG_VISITOR)
        list(APPEND cmd_args -visitor)
    else()
        list(APPEND cmd_args -no-visitor)
    endif()

    add_custom_command(
        OUTPUT "${ARG_LEXER}.cpp" "${ARG_PARSER}.cpp"
        DEPENDS "${ARG_LEXER}.g4" "${ARG_PARSER}.g4"
        COMMAND ${Java_JAVA_EXECUTABLE} ARGS ${cmd_args}
    )
endfunction()

message(STATUS "ANTLR_JAR ${ANTLR_JAR}")
message(STATUS "ANTLR_RUNTIME_LIB ${ANTLR_RUNTIME_LIB}")
message(STATUS "ANTLR_RUNTIME_INCLUDE_DIR ${ANTLR_RUNTIME_INCLUDE_DIR}")
message(STATUS "Java_JAVA_EXECUTABLE ${Java_JAVA_EXECUTABLE}")
