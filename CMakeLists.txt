cmake_minimum_required(VERSION 3.16)

project(GeigerPro VERSION 0.1 LANGUAGES CXX)

set(PROJECT_VERSION_CODE 1)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appGeigerPro
    main.cpp
)

qt_add_qml_module(appGeigerPro
    URI GeigerPro
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES res.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appGeigerPro PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appGeigerPro
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appGeigerPro
    PRIVATE Qt6::Quick
)

set(ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android)

set_target_properties(appGeigerPro PROPERTIES
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
    QT_ANDROID_VERSION_CODE ${PROJECT_VERSION_CODE}
    QT_ANDROID_VERSION_NAME "${PROJECT_VERSION}"
    QT_ANDROID_TARGET_SDK_VERSION "36"
    QT_ANDROID_MIN_SDK_VERSION "21"
    QT_ANDROID_EXTRA_LIBS "${ANDROID_EXTRA_LIBS}"
    QT_ANDROID_EXTRA_ARGUMENTS "--android-platform android-36"
)

include(GNUInstallDirs)
install(TARGETS appGeigerPro
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
