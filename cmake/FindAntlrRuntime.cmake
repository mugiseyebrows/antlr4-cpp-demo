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
    set(options)
    set(oneValueArgs LEXER PARSER NAMESPACE)
    set(multiValueArgs)
    cmake_parse_arguments(NAME "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    add_custom_command(
        OUTPUT "${NAME_LEXER}.cpp" "${NAME_PARSER}.cpp"
        DEPENDS "${NAME_LEXER}.g4" "${NAME_PARSER}.g4"
        COMMAND ${Java_JAVA_EXECUTABLE} -jar ${ANTLR_JAR} -Dlanguage=Cpp -package ${NAME_NAMESPACE} "${CMAKE_CURRENT_SOURCE_DIR}/${NAME_LEXER}.g4" "${CMAKE_CURRENT_SOURCE_DIR}/${NAME_PARSER}.g4"
    )
endfunction()

message(STATUS "ANTLR_JAR ${ANTLR_JAR}")
message(STATUS "ANTLR_RUNTIME_LIB ${ANTLR_RUNTIME_LIB}")
message(STATUS "ANTLR_RUNTIME_INCLUDE_DIR ${ANTLR_RUNTIME_INCLUDE_DIR}")
message(STATUS "Java_JAVA_EXECUTABLE ${Java_JAVA_EXECUTABLE}")
