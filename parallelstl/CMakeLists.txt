#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(parallelstl
  GIT_REPOSITORY "https://git01.codeplex.com/parallelstl"
  GIT_TAG "04b3df28bba9f1750f0a3ee7ae93a9a682f3ba27"
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
)
copy_files(parallelstl
  CMakeLists.txt
  ParallelSTLConfig.cmake.in
)
