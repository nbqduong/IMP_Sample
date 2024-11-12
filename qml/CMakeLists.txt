#-------------------DEFINE ZONE----------------------#
#this library
set(LIBRARY_NAME "ui")
set(LIBRARY_INCLUDES "./" "${CMAKE_BINARY_DIR}/configured_files/include")

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)


qt_add_qml_module(${LIBRARY_NAME}
    URI IMP_First
    VERSION 1.0
    QML_FILES
    Main.qml
)


target_link_libraries(${LIBRARY_NAME}
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS ${LIBRARY_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Resources:
set(declarative-camera_resource_files
    "Main.qml"
)

qt_add_resources(${LIBRARY_NAME} "declarative-camera"
    PREFIX
        "/"
    FILES
        ${declarative-camera_resource_files}
)
