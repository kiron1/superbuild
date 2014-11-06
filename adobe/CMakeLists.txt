#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(adobe-source-libraries
  DEPENDS boost
  GIT_REPOSITORY "https://github.com/stlab/adobe_source_libraries"
  GIT_TAG "3d845219da423f7278bbef07b0ccc0322cd17304"
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
)
copy_files(adobe-source-libraries
  CMakeLists.txt
  AdobeSourceLibrariesConfig.cmake.in
)
