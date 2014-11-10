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

find_package(BoostFilesystem QUIET)
find_package(BoostSystem QUIET)
find_package(BoostThread QUIET)

project(AdobeSourceLibraries VERSION 0.1.0 LANGUAGES CXX)

include(GNUInstallDirs)

option(${PROJECT_NAME}_HEAD_ONLY "Do not build library, use header only part" Yes)

set(_config_cmake_in      "${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}Config.cmake.in")
set(_config_cmake         "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake")
set(_config_version_cmake "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake")
set(_targets_cmake        "${PROJECT_NAME}Targets.cmake")
set(_pkg_dest             "${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake")


if(TARGET boost::filesystem AND TARGET boost::system AND TARGET boost::thread)
  set(_can_build_asl YES)
else()
  set(_can_build_asl NO)
endif()

if(_can_build_asl AND NOT ${PROJECT_NAME}_HEAD_ONLY)
  add_library(source_libraries
    source/adam.cpp
    source/adam_evaluate.cpp
    source/adam_parser.cpp
    source/any_regular.cpp
    source/empty.cpp
    source/eve.cpp
    source/eve_evaluate.cpp
    source/eve_parser.cpp
    source/expression_filter.cpp
    source/expression_parser.cpp
    source/extents.cpp
    source/external_model.cpp
    source/iomanip.cpp
    source/iomanip_asl_cel.cpp
    source/iomanip_javascript.cpp
    source/iomanip_pdf.cpp
    source/iomanip_xml.cpp
    source/istream.cpp
    source/lex_shared.cpp
    source/lex_stream.cpp
    source/localization.cpp
    source/md5.cpp
    source/memory.cpp
    source/name.cpp
    source/parser_shared.cpp
    source/string.cpp
    source/string_pool.cpp
    source/test_configuration.cpp
    source/thread_id.cpp
    source/token.cpp
    source/typeinfo.cpp
    source/unicode.cpp
    source/virtual_machine.cpp
    source/xml_lex.cpp
    source/xml_parser.cpp
    source/xml_token.cpp
    source/xstring.cpp
    source/zuid.cpp
    source/zuid_sys_dep.cpp
    source/zuid_uuid.cpp
  )
  target_link_libraries(source_libraries PUBLIC
    boost::filesystem
    boost::system
    boost::thread
  )
  set(_scope PUBLIC)
else()
  # add header only interface library
  add_library(source_libraries INTERFACE)
  set(_scope INTERFACE)
endif()
add_library(adobe::source_libraries ALIAS source_libraries)
if(CMAKE_SYSTEM_NAME MATCHES "Windows" OR CMAKE_SYSTEM_NAME MATCHES "CYGWIN")
  target_compile_definitions(source_libraries ${_scope}
    WINVER=0x560
    _WIN32_WINNT=0x560
    _WIN32_IE=0x560
  )
endif()
target_include_directories(source_libraries ${_scope}
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)
install(TARGETS source_libraries EXPORT "${PROJECT_NAME}"
  RUNTIME       DESTINATION ${CMAKE_INSTALL_BINDIR}     COMPONENT "${PROJECT_NAME}"
  LIBRARY       DESTINATION ${CMAKE_INSTALL_LIBDIR}     COMPONENT "${PROJECT_NAME}"
  ARCHIVE       DESTINATION ${CMAKE_INSTALL_LIBDIR}     COMPONENT "${PROJECT_NAME}-dev"
  INCLUDES      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
install(EXPORT "${PROJECT_NAME}"
  NAMESPACE "adobe::"
  FILE "${_targets_cmake}"
  DESTINATION "${_pkg_dest}"
  COMPONENT   "${PROJECT_NAME}-dev"
)
install(DIRECTORY adobe
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  COMPONENT   "${PROJECT_NAME}-dev"
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${_config_version_cmake}"
  VERSION "${AdobeSourceLibraries_VERSION}"
  COMPATIBILITY AnyNewerVersion
)
configure_package_config_file(
  "${_config_cmake_in}"
  "${_config_cmake}"
  INSTALL_DESTINATION "${_pkg_dest}"
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  PATH_VARS CMAKE_INSTALL_INCLUDEDIR
)
install(FILES
  "${_config_cmake}"
  "${_config_version_cmake}"
  DESTINATION "${_pkg_dest}"
)

