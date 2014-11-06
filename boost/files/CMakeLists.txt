#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
cmake_policy(VERSION 3.0)

set(_boost_src ${CMAKE_CURRENT_SOURCE_DIR})
set(_boost_bin ${CMAKE_CURRENT_BINARY_DIR})

file(STRINGS "${_boost_src}/boost/version.hpp"
  _boost_VERSION_HPP_CONTENTS REGEX
  "#define BOOST_VERSION "
)
if(_boost_VERSION_HPP_CONTENTS MATCHES ".*#define BOOST_VERSION ([0-9]+).*")
  set(_pv "${CMAKE_MATCH_1}")
else()
  message(FATAL_ERROR "Failed to retrive boost version.")
endif()

project(Boost LANGUAGES C CXX VERSION ${_pv})
string(TOLOWER "${PROJECT_NAME}" PACKAGE_NAME)

include(GNUInstallDirs)

set(_build_flags)
if(CMAKE_CXX_COMPILER_ID MATCHES Clang)
  set(_toolset clang)
  set(_build_flags cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++")
elseif(CMAKE_CXX_COMPILER_ID MATCHES GNU)
  set(_toolset gcc)
elseif(CMAKE_CXX_COMPILER_ID MATCHES HP)
  set(_toolset hp_cxx)
elseif(CMAKE_CXX_COMPILER_ID MATCHES SunPro)
  set(_toolset sun)
else() # msvc, intel, borland
  string(TOLOWER "${CMAKE_CXX_COMPILER_ID}" _toolset)
endif()

set(${PROJECT_NAME}_WITH_LIBRARIES "" CACHE STRING "Comma seperated list of libraries to build")
set(${PROJECT_NAME}_BUILD_FLAGS "${_build_flags}" CACHE STRING "Extra arguments for b2 when building Boost")
set(${PROJECT_NAME}_BUILD_TOOSET ${_toolset} CACHE STRING "Toolset to use when building Boost")
set_property(CACHE ${PROJECT_NAME}_BUILD_TOOSET PROPERTY STRINGS
  acc borland como darwin gcc hp_cxx intel msvc sun vacpp
)

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
  set(_b2_configure "${_boost_src}/bootstrap.bat")
  set(_b2_exe "${_boost_src}/b2.exe")
else()
  set(_b2_configure "${_boost_src}/bootstrap.sh")
  set(_b2_exe "${_boost_src}/b2")
endif()

set(_boost_build_path "${_boost_src}/tools/build")
set(ENV{BOOST_BUILD_PATH} "${_boost_build_path}")
set(ENV{BOOST_ROOT} "${_boost_src}")

add_custom_command(
  OUTPUT ${_b2_exe}
  COMMAND ${_b2_configure}
  WORKING_DIRECTORY ${_boost_src}
)
add_custom_target(bootstrap ALL
  DEPENDS ${_b2_exe}
  COMMENT "Bootstrap Boost.Build..."
)

if(${PROJECT_NAME}_WITH_LIBRARIES)
  string(REPLACE "," ";" _with_libraries ${${PROJECT_NAME}_WITH_LIBRARIES})
else()
  set(_with_libraries)
endif()

set(_stage_args
  toolset=${${PROJECT_NAME}_BUILD_TOOSET}
  ${${PROJECT_NAME}_BUILD_FLAGS}
)
foreach(_lib IN LISTS _with_libraries)
  list(APPEND _stage_args --with-${_lib})
endforeach()

add_custom_target(stage ALL
  DEPENDS bootstrap
  COMMAND "${_b2_exe}" ${_stage_args} stage
  WORKING_DIRECTORY ${_boost_src}
)

function(write_boost_config _camel_comp _snake_comp _library)
  include(CMakePackageConfigHelpers)
  set(_name                 "Boost${_camel_comp}")
  set(_export_config_cmake  "${CMAKE_CURRENT_BINARY_DIR}/${_name}Config.cmake")
  set(_install_config_cmake "${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/${_name}Config.cmake")
  set(_config_version_cmake "${CMAKE_CURRENT_BINARY_DIR}/${_name}ConfigVersion.cmake")
  set(_pkg_dest             "${CMAKE_INSTALL_DATADIR}/${_name}/cmake")

  set(COMPONENT "${_snake_comp}")
  set(COMPONENT_DEPENDENCIES "Boost")
  if(_library)
    set(_config_cmake_in "BoostLibraryComponentConfig.cmake.in")
  else()
    set(_config_cmake_in "BoostComponentConfig.cmake.in")
  endif()

  configure_package_config_file(
    "${_config_cmake_in}"
    "${_install_config_cmake}"
    INSTALL_DESTINATION "${_pkg_dest}"
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    PATH_VARS
      CMAKE_INSTALL_BINDIR
      CMAKE_INSTALL_LIBDIR
      CMAKE_INSTALL_INCLUDEDIR
      CMAKE_INSTALL_DATADIR
  )

  install(FILES "${_install_config_cmake}"
    DESTINATION "${_pkg_dest}"
    COMPONENT "${PACKAGE_NAME}-dev"
  )

  configure_package_config_file(
    "${_config_cmake_in}"
    "${_export_config_cmake}"
    INSTALL_DESTINATION "${CMAKE_CURRENT_BINARY_DIR}"
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    PATH_VARS
      CMAKE_INSTALL_BINDIR
      CMAKE_INSTALL_LIBDIR
      CMAKE_INSTALL_INCLUDEDIR
      CMAKE_INSTALL_DATADIR
  )
  export(PACKAGE ${_name})

  write_basic_package_version_file(
    "${_config_version_cmake}"
    VERSION "${${PROJECT_NAME}_VERSION}"
    COMPATIBILITY SameMajorVersion
  )
  install(FILES "${_config_version_cmake}"
    DESTINATION "${_pkg_dest}"
    COMPONENT "${PACKAGE_NAME}-dev"
  )
endfunction()

write_boost_config(Array             array               NO)
write_boost_config(Filesystem        filesystem          YES)
write_boost_config(Io                io                  NO)
write_boost_config(ProgramOptions    program_options     YES)
write_boost_config(Range             range               NO)
write_boost_config(SmartPtr          smart_ptr           NO)
write_boost_config(Spirit            spirit              NO)
write_boost_config(System            system              YES)
write_boost_config(UnitTestFramework unit_test_framework YES)
write_boost_config(Variant           variant             NO)

install(DIRECTORY boost
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  COMPONENT "${PACKAGE_NAME}-dev"
)
install(DIRECTORY stage/lib/
  DESTINATION ${CMAKE_INSTALL_LIBDIR}
  COMPONENT "${PACKAGE_NAME}-dev"
)
install(PROGRAMS ${_b2_exe}
  DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT "${PACKAGE_NAME}-build"
)
install(DIRECTORY ${_boost_build_path}
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PACKAGE_NAME}/build
  COMPONENT "${PACKAGE_NAME}-build"
)

