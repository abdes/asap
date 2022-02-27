.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

.. _useful-commands:

************************
Know the useful commands
************************

.. |date| date::

Last Updated on |date|

With your project properly forked->renamed->cloned, here are a couple of useful
commands you can immediately try out to see the project in action. Many of these
commands will be extensively documented in later chapters.

List all available `cmake` presets
  .. code:: bash

    ❯ cmake --list-presets
    Available configure presets:

      "dev-windows"
      "rel-windows"

  .. tip::

    on a Linux or macOS system, the list of available presets will change. For
    example on Linux, the list would like like this:

    .. code:: bash

      Available configure presets:

      "dev-linux"
      "dev-clang"
      "dev-gcc"
      "dev-valgrind"
      "dev-sanitizers"
      "dev-sanitizers-thread"
      "rel-linux"

Configure the project
  .. code:: bash

    cmake --preset=dev-windows

Build the project (default targets)
  .. code:: bash

    cmake --build --preset=dev-windows

Build specific target
  .. code:: bash

    cmake --build --preset=dev-windows --target=asap_common_test

Build and run all tests
  .. code:: bash

    cmake --build --preset=dev-windows --target=do-all-tests

Build `doxygen` and `sphinx` documentation
  .. code:: bash

    cmake --build --preset=dev-windows --target=dox --target=sphinx

Open a browser with the documentation (Windows)
  .. code:: powershell

    start out/build/dev-windows/sphinx/index.html

Run tests with `ctest`
  .. code:: powershell

    cmake --build --preset=dev-windows --target=test

Clean the project build
  .. code:: powershell

    cmake --build --preset=dev-windows --target=clean
