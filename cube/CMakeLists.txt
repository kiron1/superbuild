#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================


ExternalProject_Add(cube
  DEPENDS         boost
  GIT_REPOSITORY  https://github.com/kiron1/cube
  GIT_TAG         master
  CMAKE_ARGS      ${_cmake_args}
  TEST_COMMAND    ""
)

