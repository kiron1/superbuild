#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(urdl
  GIT_REPOSITORY "https://github.com/chriskohlhoff/Urdl.git"
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
  DEPENDS boost
)
copy_files(urdl
  CMakeLists.txt
  UrdlConfig.cmake.in
)
