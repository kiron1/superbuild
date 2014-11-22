#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(boost-expected
  GIT_REPOSITORY "https://github.com/ptal/expected"
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
  DEPENDS boost
)
copy_files(boost-expected
  CMakeLists.txt
  BoostExpectedConfig.cmake.in
)

