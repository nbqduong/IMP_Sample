cmake_minimum_required(VERSION 3.16)
#-------------------DEFINE ZONE----------------------#
#Project name
set(PROJECT_NAME appIMP_First)

##INFORMATION AND CONFIGURATION
project(${PROJECT_NAME} VERSION 0.1 LANGUAGES CXX)

# Global CMake variables are set here
set(CMAKE_PREFIX_PATH "/home/duong/Qt/6.7.2/gcc_64")

#Aditional pakage and libraries
set(ADDITIONAL_PAKAGES Quick)
set(ADDITIONAL_LIBRARIES Qt6::Quick plugin)


#subfolders
add_subdirectory(Source)

#QML files
set(QML_FILES QMLDir/Main.qml)
set(CPP_QML_FILES Source/test.h)

#----------------------------------------------------#

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

find_package(Qt6 6.2 REQUIRED COMPONENTS ${ADDITIONAL_PAKAGES})


qt_add_qml_module(${PROJECT_NAME}
    URI IMP_First
    VERSION 1.0
    QML_FILES
        ${QML_FILES}
        RESOURCES qml.qrc
        RESOURCES ${CPP_QML_FILES}
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appIMP_First PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appIMP_First
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE ${ADDITIONAL_LIBRARIES}
)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


# Resources:
set(imp_files
    ${QML_FILES}
)

qt_add_resources(${PROJECT_NAME}  "IMP_First"
    PREFIX
        "/"
    FILES
        ${imp_files}
)

