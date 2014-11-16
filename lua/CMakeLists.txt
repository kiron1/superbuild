#=============================================================================
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

ExternalProject_Add(lua
  URL http://www.lua.org/ftp/lua-5.2.2.tar.gz
  URL_MD5 efbb645e897eae37cad4344ce8b0a614 
  CMAKE_ARGS ${_cmake_args}
  TEST_COMMAND ""
)
copy_files(lua
  CMakeLists.txt
  LuaConfig.cmake.in
)

