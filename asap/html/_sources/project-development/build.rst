.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

******************
Build instructions
******************

.. |date| date::

Last Updated on |date|

The project uses `CMake` as a build system and defines `presets` in the
`CmakePrests.json` file that describe the most commonly used configuration,
build and test settings. While you can still use the traditional way of invoking
`cmake` commands in a build directory, we recommend that you understand and
embrace the cmake presets way, which simplifies the command lines required to
invoke `cmake` and integrates nicely with the most commonly used IDEs.

Build targets
=============

The project defines a number of targets that can be used to build specific
artifacts or groups of related artifacts.

:all: build all primary targets of the project. That includes all library and
  executable targets defined using the `asap_add_library` and
  `asap_add_executable` commands. Each of these targets may also be built
  individually. Tests are usually excluded from the ```all``` target unless they
  have been added with the `POST_BUILD` option.

:build-all-tests: build all tests added using the `asap_add_test` or
  `asap_add_test_runner` commands.

:build-all-post-build-tests: build all tests added using the `asap_add_test` or
  `asap_add_test_runner` commands and with the option `POST_BUILD`. Such tests
  are also built as part of the ```all``` target.

:do-all-tests: builds and runs all tests added using the `asap_add_test` or
  `asap_add_test_runner` commands, including unit tests and integration tests.

:do-all-unit-tests: builds and runs all tests added using the `asap_add_test` or
  `asap_add_test_runner` commands with the option `UNIT_TEST`.

:do-all-integration-tests: builds and runs all tests added using the
  `asap_add_test` or `asap_add_test_runner` commands with the option
  `INTEGRATION_TEST`.

:dox: build `doxygen` documentation. This target is only available when
  `doxygen` and its dependencies (such as `graphviz`) have been properly
  detected and were found.

:sphinx: build `sphinx` documentation. This target is only available when
  `sphinx` and its dependencies have been properly detected and were found. A
  complete documentation also requires doxygen documentation to have been built
  prior to building the `sphinx` manual. Such dependency is not enforced in the
  targets graph to make it faster to build `sphinx` docs without rebuilding
  `doxygen` docs each time.

The following targets are only defined when code coverage tools have been
detected on the system. Such tools depend on the compiler being used (clang or
gcc, MSVC is not supported).

:ccov-all: run all tests to collect code coverage statistics and produce a
  consolidated report in HTML for all the source files included in coverage
  collection.

:ccov-xxxtargetxxx: where xxxtargetxxx refers to a specific executable target in
  the project. Run the executable with code coverage collection enabled and
  produce a html report just for that target. This can be used to run code
  coverage analysis just for a specific test.

:ccov-clean: clean intermediary files generated for code coverage analysis.

The following targets are only defined if the `clang-format` tool has been
properly detected and found on the system.

:clang-format: Shows which files are affected by `clang-format`.

:check-clang-format: Errors if files are affected by `clang-format` (for CI
  integration).

:fix-clang-format: Applies `clang-format` to all affected files.

The following targets are only defined if the `cmake-format` tool has been
properly detected and found on the system.

:cmake-format: Shows which files are affected by `cmake-format`.

:check-cmake-format: Errors if files are affected by `cmake-format` (for CI
  integration).

:fix-cmake-format: Applies `cmake-format` to all affected files.

The following targets combine the above two categories of targets.

:format: Shows which files are affected by `cmake-format` or `clang-format`.

:check-format: Errors if files are affected by `cmake-format` or `clang-format`
  (for CI integration).

:fix-format: Applies `cmake-format` or `clang-format` to all affected files.

The following target are only defined if the compiler is `clang`, the
`clang-tidy` tool has been properly detected and found on the system.

:clang-tidy-all: lints all C++ source code files in the project using
  `clang-tidy`.

:clang-tidy-all-check: lints all C++ source code files in the project using
  `clang-tidy` and exits with a non-zero exit-code if any warnings were
  generated.

:clang-tidy-diff: formats only changed C++ source code files in the project
  using `clang-format`.

:clang-tidy-diff-check: lints only changed C++ source code files in the project
  using `clang-tidy` and exits with a non-zero exit-code if any warnings were
  generated.

.. note::

  Targets for running `clang-tidy` on a specific target in the project are also
  defined. For example to run it on the `asap_common` module, use
  `clang-tidy-asp_common`.

`CMake` Presets
===============

CMake supports two files, `CMakePresets.json` and `CMakeUserPresets.json`, that
allow users to specify common configure options and share them with others.

`CMakePresets.json` and `CMakeUserPresets.json` live in the project's root
directory. They both have exactly the same format. `CMakePresets.json` is meant
to save project-wide builds, while `CMakeUserPresets.json` is meant for
developers to save their own local builds. `CMakePresets.json` may be checked
into a version control system, and `CMakeUserPresets.json` should NOT be checked
in.

For a complete description of the format refer to the `cmake-presets
documentation
<https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html#id3>`_.

This project defines presets in a hierarchical way and uses 'mixins' to add
specific aspects of the build configuration such as debug/release, code
coverage, etc. Once you understand the format of the presets files, it's easy to
understand the logic and the reasoning behind how `asap` presets are defined.

.. literalinclude:: ../../CMakePresets.json
  :language: json
  :linenos:
  :emphasize-lines: 8,255,387

Integration in IDEs
===================

Refer to the relevant documentation of the IDE you are using to understand how
cmake presets are integrated in the IDE and how you can select the right preset
for configure, build and test phases.

Command-line build with presets
===============================

.. note::
  All output goes into the `out` directory under the project root.

  All commands should be run from the project root.

Configure
---------

.. code-block:: shell

  $ cmake --preset=dev-linux

Build
-----

.. code-block:: shell

  $ cmake --build --preset=dev-linux

  $ cmake --build --preset=dev-linux --target=dox

Test
----

.. code-block:: shell

  $ cmake --build --preset=dev-linux --target=test

  $ cmake --build --preset=dev-linux --target=do-all-tests

Run tests with code coverage collection enabled:

.. code-block:: shell

  $ cmake --build --preset=dev-linux --target=ccov-all

Run tests with sanitizers enabled:

.. code-block:: shell

  $ cmake --preset=dev-sanitizers
  $ cmake --build --preset=dev-sanitizers --target=do-all-tests

Run tests with `valgrind` enabled (output reports are in
`out/build/dev-valgrind/profiling`):

.. code-block:: shell

  $ cmake --preset=dev-valgrind
  $ cmake --build --preset=dev-valgrind --target=do-all-valgrind
