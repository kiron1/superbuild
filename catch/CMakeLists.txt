#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(catch
  GIT_REPOSITORY "https://github.com/philsquared/Catch.git"
  CMAKE_GENERATOR ${CMAKE_GENERATOR}
  CMAKE_GENERATOR_PLATFORM ${CMAKE_GENERATOR_PLATFORM}
  CMAKE_GENERATOR_TOOLSET ${CMAKE_GENERATOR_TOOLSET}
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
)
copy_files(catch
  CMakeLists.txt
  CatchConfig.cmake.in
)
