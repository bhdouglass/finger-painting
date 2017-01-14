project(finger-painting C CXX)
cmake_minimum_required(VERSION 2.8.9)

# Do not remove this line, its required for the correct functionality of the Ubuntu-SDK
set(UBUNTU_MANIFEST_PATH "manifest.json.in" CACHE INTERNAL "Tells QtCreator location and name of the manifest file")

find_package(Qt5Core)
find_package(Qt5Qml)
find_package(Qt5Quick)
# Find_package(ubuntu-sdk-libs)

#automatically create moc files
set(CMAKE_AUTOMOC ON)

# Figure out the component install path
execute_process(
    COMMAND dpkg-architecture -qDEB_HOST_MULTIARCH
    OUTPUT_VARIABLE ARCH_TRIPLET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(CLICK_ARCH "all")
# If you want to add native code to your project, replace the set CLICK_ARCH command
# with the following part.
# This command figures out the target architecture for use in the manifest file
# execute_process(
#   COMMAND dpkg-architecture -qDEB_HOST_ARCH
#   OUTPUT_VARIABLE CLICK_ARCH
#   OUTPUT_STRIP_TRAILING_WHITESPACE
# )

set(QT_IMPORTS_DIR "lib/${ARCH_TRIPLET}")

option(INSTALL_TESTS "Install the tests on make install" on)

set(APP_NAME          finger-painting)
set(APP_ID            "finger-painting.bhdouglass")
set(FINGER-PAINTING_DIR "app")
set(MAIN_QML          "Main.qml")
set(ICON              "graphics/finger-painting.png")

# Set install paths
set(CMAKE_INSTALL_PREFIX /)
set(DATA_DIR /)
set(DESKTOP_DIR ${DATA_DIR})
set(DESKTOP_FILE_NAME "finger-painting.desktop")

# This sets the commandline that is executed on the device
set(EXEC "qmlscene %U ${FINGER-PAINTING_DIR}/${MAIN_QML}")

# Configures the manifest file. The manifest file describes the click package
# to the target system. All cmake variables that are defined at this point
# can be used in the manifest file and will be automatically replaced by cmake
configure_file(manifest.json.in ${CMAKE_CURRENT_BINARY_DIR}/manifest.json)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/manifest.json
        DESTINATION ${CMAKE_INSTALL_PREFIX})

install(DIRECTORY "app/graphics" DESTINATION ${DATA_DIR})
install(FILES "finger-painting.apparmor" DESTINATION ${DATA_DIR})

# Translations
file(GLOB_RECURSE I18N_SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/po app/*.qml)

find_program(INTLTOOL_MERGE intltool-merge)
if(NOT INTLTOOL_MERGE)
    message(FATAL_ERROR "Could not find intltool-merge, please install the intltool package")
endif()
find_program(INTLTOOL_EXTRACT intltool-extract)
if(NOT INTLTOOL_EXTRACT)
    message(FATAL_ERROR "Could not find intltool-extract, please install the intltool package")
endif()

add_custom_target(${DESKTOP_FILE_NAME} ALL
    COMMENT "Merging translations into ${DESKTOP_FILE_NAME}..."
    COMMAND LC_ALL=C ${INTLTOOL_MERGE} -d -u ${CMAKE_SOURCE_DIR}/po ${CMAKE_SOURCE_DIR}/${DESKTOP_FILE_NAME}.in ${DESKTOP_FILE_NAME}

    # TODO see if there is a better way to do this
    COMMAND sed -i 's/finger-painting-//g' ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE_NAME}
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE_NAME} DESTINATION ${DATA_DIR})


add_subdirectory(app)
add_subdirectory(po)
