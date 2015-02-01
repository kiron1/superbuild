Superbuild
===========

CMake supberbuild (i.e. using ExternalProject) project to build external
dependencies from source.

Usage
-----

To use, [CMake](http://www.cmake.org/) 3.0 or newer is required.

Generate the project.

    cmake -H. -B_build -GNinja

Build all:

    cmake --build _build

To build only a single dependency add the ``--target`` argument.

    cmake --build _build --target boost

Packages
--------

The following packages are included:

- [catch](https://github.com/philsquared/Catch)
- [Adobe Source Libraries (ASL)](http://stlab.adobe.com/)
- [Boost](http://www.boost.org/)
- [Boost.QVM](http://www.revergestudios.com/boost-qvm/)
- [ParallelSTL](https://parallelstl.codeplex.com/)

