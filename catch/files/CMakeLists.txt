#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
cmake_policy(VERSION 3.0)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)


file(STRINGS "${CMAKE_CURRENT_SOURCE_DIR}/README.md"
    _catch_README_CONTENTS REGEX "^\\*v[0-9]+\\..*"
)
if(_catch_README_CONTENTS MATCHES "^\\*v([0-9]+)\\.([0-9]+).*")
    set(_pv "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}")
else()
    message(FATAL_ERROR "Failed to retrive Catch version.")
endif()
project(Catch VERSION ${_pv} LANGUAGES CXX)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_library(catch INTERFACE)
target_include_directories(catch
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_compile_options(catch
    INTERFACE
        $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:GNU>>:-std=c++11>
        $<$<CXX_COMPILER_ID:Clang>:-stdlib=libc++>
)
target_link_libraries(catch
    INTERFACE
        $<$<CXX_COMPILER_ID:Clang>:c++>
)

add_library(${PROJECT_NAME}::catch ALIAS catch)

install(TARGETS catch EXPORT ${PROJECT_NAME}
    RUNTIME       DESTINATION ${CMAKE_INSTALL_BINDIR}     COMPONENT "${PROJECT_NAME}"
    LIBRARY       DESTINATION ${CMAKE_INSTALL_LIBDIR}     COMPONENT "${PROJECT_NAME}"
    ARCHIVE       DESTINATION ${CMAKE_INSTALL_LIBDIR}     COMPONENT "${PROJECT_NAME}-dev"
    INCLUDES      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
install(DIRECTORY
    include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/catch
    COMPONENT "${PROJECT_NAME}-dev"
)
install(EXPORT ${PROJECT_NAME}
    NAMESPACE   ${PROJECT_NAME}::
    FILE        ${PROJECT_NAME}Targets.cmake
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
    COMPONENT   ${PROJECT_NAME}-dev
)

write_basic_package_version_file(
    ${PROJECT_NAME}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(
    ${PROJECT_NAME}Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION share/${PROJECT_NAME}/cmake
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    PATH_VARS CMAKE_INSTALL_INCLUDEDIR
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${PROJECT_NAME}Config.cmake
    DESTINATION share/${PROJECT_NAME}/cmake
)

configure_package_config_file(
    ${PROJECT_NAME}Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    PATH_VARS CMAKE_INSTALL_INCLUDEDIR
)
export(EXPORT ${PROJECT_NAME}
    NAMESPACE ${PROJECT_NAME}::
    FILE ${PROJECT_NAME}Targets.cmake
)
export(PACKAGE ${PROJECT_NAME})

