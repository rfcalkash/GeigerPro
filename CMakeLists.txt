cmake_minimum_required(VERSION 3.16)

project(GeigerPro VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick)

set(PROJECT_SOURCES
    main.cpp
    ${QML_FILES}
    ${RESOURCE_FILES}
    translations/translations.ts
    translations/translations_en.ts
    translations/translations_de.ts
    translations/translations_fr.ts
    translations/translations_uk.ts
    translations/translations_zh.ts
    translations/translations_ja.ts
)

qt_add_executable(GeigerPro
    ${PROJECT_SOURCES}
)

qt_add_qml_module(GeigerPro
    URI GeigerPro
    VERSION 1.0
    QML_FILES ${QML_FILES}
    RESOURCES ${RESOURCE_FILES}
)

target_link_libraries(GeigerPro
    PRIVATE Qt6::Core
    PRIVATE Qt6::Quick
    PRIVATE Qt6::SerialPort
)

# Создаем файлы .qm из .ts
find_program(LRELEASE_EXECUTABLE lrelease)
if(LRELEASE_EXECUTABLE)
    set(TS_FILES
        translations/translations.ts
        translations/translations_en.ts
        translations/translations_de.ts
        translations/translations_fr.ts
        translations/translations_uk.ts
        translations/translations_zh.ts
        translations/translations_ja.ts
    )
    
    foreach(TS_FILE ${TS_FILES})
        get_filename_component(TS_NAME ${TS_FILE} NAME_WE)
        set(QM_FILE ${CMAKE_CURRENT_BINARY_DIR}/${TS_NAME}.qm)
        add_custom_command(
            OUTPUT ${QM_FILE}
            COMMAND ${LRELEASE_EXECUTABLE} ${TS_FILE} -qm ${QM_FILE}
            DEPENDS ${TS_FILE}
        )
        list(APPEND QM_FILES ${QM_FILE})
    endforeach()
    
    add_custom_target(translations ALL DEPENDS ${QM_FILES})
    add_dependencies(GeigerPro translations)
endif()

# iOS specific settings
if(IOS)
    set_target_properties(GeigerPro PROPERTIES
        MACOSX_BUNDLE TRUE
        MACOSX_BUNDLE_GUI_IDENTIFIER com.example.GeigerPro
        MACOSX_BUNDLE_BUNDLE_NAME GeigerPro
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    )
endif()

# Android specific settings
if(ANDROID)
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    if(NOT EXISTS "${ANDROID_PACKAGE_SOURCE_DIR}")
        file(MAKE_DIRECTORY "${ANDROID_PACKAGE_SOURCE_DIR}")
    endif()
    
    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    set(ANDROID_ABIS arm64-v8a armeabi-v7a x86_64)
    
    qt_add_android_apk(GeigerPro
        NAME "GeigerPro"
        PACKAGE_NAME "org.qtproject.GeigerPro"
        VERSION_NAME ${PROJECT_VERSION}
        VERSION_CODE 1
        ANDROID_ABIS ${ANDROID_ABIS}
        ANDROID_PACKAGE_SOURCE_DIR ${ANDROID_PACKAGE_SOURCE_DIR}
        ANDROID_EXTRA_LIBS
            ${CMAKE_CURRENT_SOURCE_DIR}/android/libs/${ANDROID_ABI}/libc++_shared.so
    )
endif()

# Installation
install(TARGETS GeigerPro
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install translations
install(FILES ${QM_FILES}
    DESTINATION ${CMAKE_INSTALL_DATADIR}/GeigerPro/translations
)
