#-------------------DEFINE ZONE----------------------#
#this library
set(LIBRARY_NAME "backend")
set(LIBRARY_INCLUDES "./" "${CMAKE_BINARY_DIR}/configured_files/include")

set(LIBRARY_SOURCES
        interface.cpp
        filter.cpp
)
set(LIBRARY_HEADERS
        interface.h
        filter.h
        database.h
)
# Global CMake variables are set here
set(CMAKE_PREFIX_PATH "/home/duong/Qt/6.7.2/gcc_64")

#Aditional pakage
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)
find_package( OpenCV REQUIRED )

#include and link more
include_directories( ${OpenCV_INCLUDE_DIRS} )
set(LIBRARIES_TO_LINK Qt6::Quick ${OpenCV_LIBS})
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

