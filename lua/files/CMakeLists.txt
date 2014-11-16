#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
cmake_policy(VERSION 3.0)

# add this options before PROJECT keyword
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(Lua VERSION 5.2.2 LANGUAGES C)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_library(lua
  src/lapi.c
  src/lcode.c
  src/lctype.c
  src/ldebug.c
  src/ldo.c
  src/ldump.c
  src/lfunc.c
  src/lgc.c
  src/llex.c
  src/lmem.c
  src/lobject.c
  src/lopcodes.c
  src/lparser.c
  src/lstate.c
  src/lstring.c
  src/ltable.c
  src/ltm.c
  src/lundump.c
  src/lvm.c
  src/lzio.c
  src/lauxlib.c
  src/lbaselib.c
  src/lbitlib.c
  src/lcorolib.c
  src/ldblib.c
  src/liolib.c
  src/lmathlib.c
  src/loslib.c
  src/lstrlib.c
  src/ltablib.c
  src/loadlib.c
  src/linit.c
)
target_include_directories(lua
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(lua
  PUBLIC
    m
)

add_executable(luainterp
  src/lua.c
)
target_link_libraries(luainterp PRIVATE lua)

add_executable(luac
  src/luac.c
)
target_link_libraries(luac PRIVATE lua)

install(TARGETS lua luainterp luac EXPORT "${PROJECT_NAME}"
  RUNTIME       DESTINATION ${CMAKE_INSTALL_BINDIR}     COMPONENT "${PROJECT_NAME}"
  LIBRARY       DESTINATION ${CMAKE_INSTALL_LIBDIR}     COMPONENT "${PROJECT_NAME}"
  ARCHIVE       DESTINATION ${CMAKE_INSTALL_LIBDIR}     COMPONENT "${PROJECT_NAME}-dev"
)
install(FILES src/lua.h src/luaconf.h src/lualib.h src/lauxlib.h src/lua.hpp 
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  COMPONENT   "${PROJECT_NAME}-dev"
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
  ${PROJECT_NAME}Config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
)

