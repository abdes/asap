.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

*******
Modules
*******

.. |date| date::

Last Updated on |date|

The `asap` project architecture adopts a modular approach as described in
:doc:`/getting-started/structure` document. This structure allows you to
easily add, remove and compose modules inside the project.

Adding a module
===============

.. tip::
  :class: margin

  To add a library module, just look at one of the existing sub-modules in
  `asap` such as `common` or `logging`.

For the sake of illustrating this process, we're gonna be adding a module for an
executable program. The program will be called `myapp`, and so we will be
calling our new module `myapp-main`.

1. Create the module structure as a sub-directory of the project. This would
   look something like this:

   .. code-block:: text

    │   CMakeLists.txt
    │   README.md
    └───src
        ├───things.h
        └───main.cpp

   It's a minimal structure, and as the module gets more and more sophisticated,
   it will most likely have test cases, more implementation files, include
   headers, etc... It may even have submodules itself.

2. Create a ```CMakeLists.txt``` file and edit its content to describe how the
   targets in the module get built. Make sure to use the `asap` target helper
   functions so that you automatically benefit from all the goodness built into
   them such as linting, formatting, code coverage etc.

   For an executable target as simple as ours, the contents of the file would
   look something like this:

   .. code-block:: CMake

    # -----------------------------------------------------
    # Meta information about the this module
    # -----------------------------------------------------

    asap_declare_module(
      MODULE_NAME
      "myapp-main"
      DESCRIPTION
      "Main module for the `myapp` program"
      GITHUB_REPO
      "https://github.com/xxx/myapp"
      AUTHOR_MAINTAINER
      "The Author"
      VERSION_MAJOR
      "1"
      VERSION_MINOR
      "0"
      VERSION_PATCH
      "0")

    # =====================================================
    # Build instructions
    # =====================================================

    # -----------------------------------------------------
    # Main module target
    # -----------------------------------------------------

    set(MODULE_TARGET_NAME "myapp")

    asap_add_executable(
      ${MODULE_TARGET_NAME}
      WARNING
      SOURCES
      # Headers
      src/things.h
      # Sources
      src/main.cpp)

    target_link_libraries(
      ${MODULE_TARGET_NAME}
      PRIVATE
      GSL
      asap::common
      asap::logging)

    target_include_directories(${MODULE_TARGET_NAME} PRIVATE ${CMAKE_BINARY_DIR}/include)
    target_include_directories(${MODULE_TARGET_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)

    # =====================================================
    # Deployment instructions
    # =====================================================

    # Executable
    install(
      TARGETS ${MODULE_TARGET_NAME}
      RUNTIME DESTINATION ${INSTALL_BIN} COMPONENT programs
      BUNDLE DESTINATION ${INSTALL_BIN} COMPONENT programs)

3. Add the module to main `CMakeLists.txt` by calling
   ```add_subdirectory(myapp-main)```

   .. code-block:: cmake

    # =====================================================
    # Project modules
    # =====================================================

    add_subdirectory(common)
    add_subdirectory(logging)
    add_subdirectory(myapp-main)

4. Reconfigure your project to regenerate CMake build files with the new targets
   for the new module. You should now have a target for building the `myapp`
   executable.

Adding tests to a module
========================

Let's add some tests to the module using `Google Test Framework` as the unit
testing framework. If you decide to use a different framework, the instructions
would still be similar although you will need to link to the appropriate
libraries and add the appropriate include directories for that framework.

1. Add test cases to a `test` subdirectory under the module.

2. Add `CMakeLists.txt` under the `test` subdirectory to describe how the test
   targets are built.

   The directory structure should now look like this:

   .. code-block:: text

    │   CMakeLists.txt
    │   README.md
    ├───src
    └───test
        ├───foo_test.cpp
        └───main.cpp

   The new `CMakeLists.txt` for the test targets should contains something like
   this:

      .. code-block:: CMake

        # ====================================================
        # Build instructions
        # ====================================================

        set(MAIN_TEST_TARGET_NAME ${MODULE_TARGET_NAME}_test)

        asap_add_test(
          ${MAIN_TEST_TARGET_NAME}
          UNIT_TEST
          VALGRIND_MEMCHECK
          SRCS
          "foo_test.cpp"
          "main.cpp"
          LINK
          # Add any linked libraries here, including the module to be tested
          gtest
          gmock
          COMMENT
          "ASAP common unit tests")

        gtest_discover_tests(${MAIN_TEST_TARGET_NAME})

        # Add support for (optional) code quality tools
        asap_add_sanitizers(${MAIN_TEST_TARGET_NAME})
        swift_add_valgrind_massif(${MAIN_TEST_TARGET_NAME})
        swift_add_valgrind_callgrind(${MAIN_TEST_TARGET_NAME})

3. Add the `test` subdirectory to the module's `CMakeLists.txt`

   .. code-block:: cmake

    # -----------------------------------------------
    # Tests
    # -----------------------------------------------

    if(ASAP_BUILD_TESTS)
      add_subdirectory(test)
    endif()

Adding documentation to a module
================================

Documentation comes in two forms: `doxygen` API documentation and `sphinx`
documentation. The former is embedded in the source code files, while the latter
is written in its own separate files placed in a ```doc``` subdirectory under
the module root.

1. The contents of the `doc` directory can be started by copying some of the
   files from another existing module. In particular, the ```conf.py.in``` file,
   can be copied from an existing module and used without modification.

   The module's `CMakeLists.txt` should then be modified to add the targets for
   `doxygen` and `sphinx` documentation build as appropriate.

   .. code-block:: CMake

    # --------------------------------------------
    # API Documentation
    # --------------------------------------------

    asap_with_doxygen(
      MODULE_NAME
      ${MODULE_TARGET_NAME}
      VERSION
      ${META_MODULE_VERSION}
      TITLE
      "\"MyApp Module\""
      BRIEF
      "\"Provides some stuff for MyApp.\""
      INPUT_PATH
      "${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_SOURCE_DIR}/include")

    asap_with_sphinx(${MODULE_TARGET_NAME})

2. Add target dependencies from the master sphinx documentation target to the
   module's sphinx documentation target. This step is only required if you have
   added a module sphinx documentation target.

   .. code-block:: CMake

    add_dependencies(master_sphinx
      copy_doc_index
      # Hardcode `asap` in the module name as we do not want this prefix to
      # change with the forked project name.
      asap_common_sphinx
      asap_logging_sphinx
      # Add more submodule documentation targets after this, using variables
      # in the target names consistently with the module's CMakeLists.txt.
      myapp
      )
