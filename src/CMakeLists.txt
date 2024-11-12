#-------------------DEFINE ZONE----------------------#
#this library
set(LIBRARY_NAME "plugin")
set(LIBRARY_INCLUDES "./" "${CMAKE_BINARY_DIR}/configured_files/include")

set(LIBRARY_SOURCES
        test.cpp
)
set(LIBRARY_HEADERS
        test.h
        test2.h

)
# Global CMake variables are set here
set(CMAKE_PREFIX_PATH "/home/duong/Qt/6.7.2/gcc_64")

#Aditional pakage
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)

#include more
set(LIBRARIES_TO_LINK Qt6::Quick)
#----------------------------------------------------#

add_library(${LIBRARY_NAME} STATIC ${LIBRARY_SOURCES} ${LIBRARY_HEADERS})
target_include_directories(${LIBRARY_NAME} PUBLIC ${LIBRARY_INCLUDES})
target_link_libraries( ${LIBRARY_NAME} PUBLIC ${LIBRARIES_TO_LINK})

if(${ENABLE_WARNINGS})
    target_set_warnings(
        TARGET
        ${LIBRARY_NAME}
        ENABLE
        ${ENABLE_WARNINGS}
        AS_ERRORS
        ${ENABLE_WARNINGS_AS_ERRORS})
endif()

if(${ENABLE_LTO})
    target_enable_lto(
        TARGET
        ${LIBRARY_NAME}
        ENABLE
        ON)
endif()

if(${ENABLE_CLANG_TIDY})
    add_clang_tidy_to_target(${LIBRARY_NAME})
endif()

# qt_add_qml_module(${LIBRARY_NAME}
#     URI learnQT111
#     VERSION 1.0
#     QML_FILES
#         SOURCES test.h test.cpp

# )
