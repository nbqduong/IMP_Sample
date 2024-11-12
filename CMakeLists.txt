cmake_minimum_required(VERSION 3.16)

project(learnQT VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Multimedia )

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(applearnQT
    main.cpp
)

qt_add_qml_module(applearnQT
    URI learnQT
    VERSION 1.0
    QML_FILES
        Main.qml
        Other.qml
        RESOURCES qml.qrc Test2.qml
        RESOURCES
        SOURCES test.h test.cpp

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(applearnQT PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.applearnQT
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(applearnQT
    PRIVATE Qt6::Quick Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS applearnQT
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Resources:
set(declarative-camera_resource_files
    "Main.qml"
    "Test2.qml"

)

qt_add_resources(applearnQT "declarative-camera"
    PREFIX
        "/"
    FILES
        ${declarative-camera_resource_files}
)
