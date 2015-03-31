#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
cmake_policy(VERSION 3.0)

# add this options before PROJECT keyword
set(CMAKE_DISABLE_SOURCE_CHANGES On)
set(CMAKE_DISABLE_IN_SOURCE_BUILD On)

project(Superbuild C CXX)

find_package(Git MODULE QUIET REQUIRED)

include(ExternalProject)

set(${PROJECT_NAME}_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/super"
  CACHE FILEPATH "Prefix used for the external projects"
)
set(${PROJECT_NAME}_INIT_CACHE_FILE ""
  CACHE FILE "CMake init-cache file used for all external projects"
)

set_property(DIRECTORY
  PROPERTY EP_PREFIX "${${PROJECT_NAME}_PREFIX}"
)

set(_cmake_args
  "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>"
  "-DCMAKE_PREFIX_PATH=${${PROJECT_NAME}_PREFIX}"
  "-DCMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY=Yes"
  "-DCMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY=Yes"
  "-DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=Yes"
)

if(${PROJECT_NAME}_INIT_CACHE_FILE)
  get_filename_component(_init_cache "${${PROJECT_NAME}_INIT_CACHE_FILE}" ABSOLUTE)
  if(EXISTS ${_init_cache})
    list(APPEND _cmake_args
      -C${_init_cache}
    )
  else()
    message(SEND_ERROR "init-cache-file `${_init_cache}' does not exists!")
  endif()
endif()

configure_file("init-cache.cmake.in" "init-cache.cmake" @ONLY)

function(copy_files _name)
  set(_cmd)
  set(_deps)
  foreach(_f IN LISTS ARGN)
    set(_src "${CMAKE_CURRENT_SOURCE_DIR}/files/${_f}")
    list(APPEND _deps ${_src})
    list(APPEND _cmd
      COMMAND ${CMAKE_COMMAND} -E copy ${_src} <SOURCE_DIR>
    )
  endforeach()
  ExternalProject_Add_Step(${_name} copyfiles
    ${_cmd}
    DEPENDEES patch
    DEPENDERS configure
    DEPENDS ${_deps}
  )
endfunction()

add_subdirectory(catch)
add_subdirectory(boost)
add_subdirectory(boost-qvm)
add_subdirectory(boost-expected)
add_subdirectory(urdl)
add_subdirectory(adobe)
add_subdirectory(parallelstl)
add_subdirectory(lua)

add_subdirectory(cube)
add_subdirectory(raptor)

