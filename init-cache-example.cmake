#
# init-cache-example.cmake
# ~~~~~~~~~~~~~~~~~~~~~~~~
#
# Usage:
# - copy file and modify to your needs.
# - add Superbuild_INIT_CACHE_FILE=init-cache-mine.cmake
#   to your cmake cache.
#

set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "")

set(_CMAKE_TOOLCHAIN_LOCATION "/usr/lib/llvm-3.5/bin" CACHE FILEPATH "")
set(CMAKE_C_COMPILER "${_CMAKE_TOOLCHAIN_LOCATION}/clang" CACHE FILEPATH "")
set(CMAKE_CXX_COMPILER "${_CMAKE_TOOLCHAIN_LOCATION}/clang++" CACHE FILEPATH "")
set(_CMAKE_TOOLCHAIN_PREFIX "llvm-" CACHE STRING "binutils prefix honored by CMakeFindBinUtils")

set(CMAKE_EXPORT_NO_PACKAGE_REGISTRY "Yes" CACHE BOOL "")
set(CMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY "Yes" CACHE BOOL "")
set(CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY "Yes" CACHE BOOL "")

