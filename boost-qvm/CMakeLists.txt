#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(boost-qvm
  URL "http://www.revergestudios.com/boost-qvm/boost-qvm.zip"
  URL_HASH SHA256=723db96be0ed8a963b4b4259db752c1fde5d5b59245dd442951319bf8f864fff
  CMAKE_GENERATOR ${CMAKE_GENERATOR}
  CMAKE_GENERATOR_PLATFORM ${CMAKE_GENERATOR_PLATFORM}
  CMAKE_GENERATOR_TOOLSET ${CMAKE_GENERATOR_TOOLSET}
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
)
copy_files(boost-qvm
  CMakeLists.txt
  BoostQVMConfig.cmake.in
)
