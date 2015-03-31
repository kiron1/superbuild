#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(double-conversion
  GIT_REPOSITORY "https://github.com/stlab/double-conversion"
  CMAKE_GENERATOR ${CMAKE_GENERATOR}
  CMAKE_GENERATOR_PLATFORM ${CMAKE_GENERATOR_PLATFORM}
  CMAKE_GENERATOR_TOOLSET ${CMAKE_GENERATOR_TOOLSET}
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
)

ExternalProject_Add(adobe-source-libraries
  DEPENDS boost double-conversion
  GIT_REPOSITORY "https://github.com/stlab/adobe_source_libraries"
  CMAKE_GENERATOR ${CMAKE_GENERATOR}
  CMAKE_GENERATOR_PLATFORM ${CMAKE_GENERATOR_PLATFORM}
  CMAKE_GENERATOR_TOOLSET ${CMAKE_GENERATOR_TOOLSET}
  CMAKE_ARGS ${_cmake_args}
  PATCH_COMMAND ${GIT_EXECUTABLE} apply "${CMAKE_CURRENT_SOURCE_DIR}/files/stlab-asl-cmake.patch"
  TEST_COMMAND ""
)
