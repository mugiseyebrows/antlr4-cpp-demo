find_library(ANTLR_RUNTIME_LIB NAMES antlr4-runtime PATH_SUFFIXES lib)
find_path(ANTLR_RUNTIME_INCLUDE_DIR antlr4-runtime.h PATH_SUFFIXES include/antlr4-runtime)
file(GLOB ANTLR_JARS "$ENV{USERPROFILE}/.m2/repository/org/antlr/antlr4/4.*/antlr4-4.*-complete.jar")

if(ANTLR_JARS)
    list(GET ANTLR_JARS -1 ANTLR_JAR)
endif()
if (ANTLR_RUNTIME_LIB AND ANTLR_RUNTIME_INCLUDE_DIR AND ANTLR_JAR)
    set(ANTLR_RUNTIME_FOUND TRUE)
else()
    set(ANTLR_RUNTIME_FOUND FALSE)
endif()

find_package(Java)

function(antlr_generate)
    set(_lexer_name ${ARGV0})
    set(_parser_name ${ARGV1})
    set(_namespace ${ARGV2})
    if (NOT Java_JAVA_EXECUTABLE)
        message("Java not found, cannot generate lexer and parser")
    endif()
    if (NOT ANTLR_JAR)
        message("Antlr jar not found, cannot generate lexer and parser")
    endif()
    if (Java_JAVA_EXECUTABLE AND ANTLR_JAR)
        # -listener -visitor
        add_custom_command(
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/generated/${_lexer_name}.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/generated/${_parser_name}.cpp"
            DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${_lexer_name}.g4" "${CMAKE_CURRENT_SOURCE_DIR}/${_parser_name}.g4"
            COMMAND ${Java_JAVA_EXECUTABLE} -jar ${ANTLR_JAR} -Dlanguage=Cpp -o generated/ -package ${_namespace} "${_lexer_name}.g4" "${_parser_name}.g4"
        )
    endif()
endfunction()

function(print_vars)
    get_cmake_property(_variableNames VARIABLES)
    list (SORT _variableNames)
    if (ARGV0)
        foreach (_variableName ${_variableNames})
            if (_variableName MATCHES ${ARGV0})
                message(STATUS "${_variableName}=${${_variableName}}")
            endif()
        endforeach()
    else() 
        foreach (_variableName ${_variableNames})
            message(STATUS "${_variableName}=${${_variableName}}")
        endforeach()
    endif()
endfunction()