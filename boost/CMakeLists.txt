#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

set(${PROJECT_NAME}_BOOST_VERSION "1.57.0" CACHE STRING "Boost version to use (e.g. 1.57.0)")

set(_boost_version "${${PROJECT_NAME}_BOOST_VERSION}")
string(REPLACE "." "_" _boost_version_us ${_boost_version})

set(_boost_sha1_1_54_0 "069501636097d3f40ddfd996d29748bb23591c53")
set(_boost_sha1_1_55_0 "61ed0e57d3c7c8985805bb0682de3f4c65f4b6e5")
set(_boost_sha1_1_56_0 "1639723c6bdff873cdb6d747f8f8c9d9f066434d")
set(_boost_sha1_1_57_0 "55366a96bb76440ab140047065650f1d73dbfd8c")

ExternalProject_Add(boost
  URL "http://downloads.sourceforge.net/project/boost/boost/${_boost_version}/boost_${_boost_version_us}.tar.gz"
  URL_HASH SHA1=${_boost_sha1_${_boost_version_us}}
  CMAKE_GENERATOR ${CMAKE_GENERATOR}
  CMAKE_GENERATOR_PLATFORM ${CMAKE_GENERATOR_PLATFORM}
  CMAKE_GENERATOR_TOOLSET ${CMAKE_GENERATOR_TOOLSET}
  CMAKE_ARGS ${_cmake_args} -DBoost_WITH_LIBRARIES=filesystem,program_options,system,test
  TEST_COMMAND ""
)
copy_files(boost
  CMakeLists.txt
  BoostLibraryComponentConfig.cmake.in
  BoostHeaderOnlyComponentConfig.cmake.in
  project-config.jam.in
)
