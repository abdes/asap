.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

*******************
Third party modules
*******************

.. |date| date::

Last Updated on |date|

The `asap` project fully leverage the open source development model by allowing
to easily add third party libraries. We want to increase reuse of existing
software but not at the cost of adding unnecessary complexity to the build
environment.

C++ does not provide any built-in package management mechanism like what we can
find in `Rust <https://doc.rust-lang.org/cargo/>`_ or `Go
<https://go.dev/doc/modules/managing-dependencies>`_.

Over time, many workaround were used to deal with this gap, including git
submodules, independent package managers such as `conan <https://conan.io/>`_,
or even copying the third party code or binaries into the project.

If we want to have any level of real dependency management, we'll need some kind
of package management. But then, the package manager itself becomes a
dependency. Everyone that wants to build our project has to install the correct
version. If you’re using CI, you have to set up everything on the build server
as well, which can be a pain.

It would be nice if we can achieve our goals with just CMake, and that's what
we're gonna do. We'll go through at least 3 methods of integrating third party
libraries/modules.

CMake ExternalProject
=====================

CMake introduced a module called ExternalProject in version 3.0. ExternalProject
wraps dependencies into a CMake target and allows managing foreign code from
your CMakeLists.txt.

To use it, one must add a target via ExternalProject_Add(). CMake will then run
the following steps for this target:

:DOWNLOAD: Download the dependency. Here one can use a version control system or
  download from an URL.

:UPDATE: Update the downloaded code if anything changed since the last CMake
  run.

:CONFIGURE: Configure the project code.

:BUILD: Build the dependencies code.

:INSTALL: Install the built code into a specified directory.

:TEST: (optional) Run tests.

All the above commands are configurable. ExternalProject also allows for custom
steps. For more information, have a look at the `documentation
<https://cmake.org/cmake/help/latest/module/ExternalProject.html>`_.

This definitely works with one small issue: when using ExternalProject, all its
steps will run at build time. This means that CMake downloads and builds your
dependencies after the generation step. So your dependencies will not be
available yet when CMake configures your project. If this is acceptable, then
`ExternalProject` is a go.

CMake FetchContent
==================

With version 3.11 CMake introduced a new module: `FetchContent
<https://cmake.org/cmake/help/latest/module/FetchContent.html>`_. The module
offers the same functionality as ExternalProject but will download dependencies
before the configure step.

Here is an example of how to use it to fetch, configure, build and make
available the Google Test libraries in the project.

.. code-block:: CMake

  include(FetchContent)
  # We make sure that we have 'thirdparty' in the name so that the targets get
  # excluded from the generated target lists for the various tools.
  set(FETCHCONTENT_BASE_DIR ${CMAKE_BINARY_DIR}/third_party_deps)
  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG # GoogleTest now follows the Abseil Live at Head philosophy. We
            # recommend using the latest commit in the main branch in your
            # projects.
    origin/main)
  # For Windows: Prevent overriding the parent project's compiler/linker settings
  set(gtest_force_shared_crt
      ON
      CACHE BOOL "" FORCE)
  FetchContent_MakeAvailable(googletest)

`FetchContent` works very well but there are a couple of things to keep in mind
when using it:

- **Downloading requires an internet connection**
  Of course, you have to be online for first downloading your dependencies.
  Compared to using git submodules, this requirement is now hidden. So you might
  forget about it when building your code. To mitigate this problem, there are
  options we can use:

  - `FETCHCONTENT_FULLY_DISCONNECTED=ON` will skip the DOWNLOAD and UPDATE steps
  - `FETCHCONTENT_UPDATES_DISCONNECTED=ON` will skip the UPDATE step

- **The library has to be installable**
  Every once in a while you will come across libraries that are missing the call
  to install() in their CMakeLists.txt. In this case, FetchContent does not know
  how to copy the built code into the install folder and will fail.

FetchContent works best with CMake based dependencies. I haven’t had a chance to
test it with libraries that are not built with CMake. But I would expect that
some extra configuration is necessary to make it work.

`CPM <https://github.com/TheLartians/CPM.cmake>`_
=================================================

CPM.cmake is a cross-platform CMake script that adds dependency management
capabilities to CMake. It's built as a thin wrapper around CMake's FetchContent
module that adds version control, caching, a simple API and more.

.. hint::
  :class: margin

  CPM is the preferred way of managing third party dependencies in asap, and is
  already integrated in the project.

Git submodules
==============

For dependencies with a modern CMake setup, this is enough to make it available
to your project. Several of the third party dependencies used in `asap` are
integrated this way. It's very simple to integrate in the master project
CMakeLists.txt, just like adding a regular module in a subdirectory.

.. code-block:: CMake

  # ---------------------------------------------
  # Third party modules
  # ---------------------------------------------

  add_subdirectory(third_party)

To keep third party modules configuration in a single place, all modules are
located under the ```third_party``` subdirectory. That directory has a
`CMakeLists.txt` file which only contains configuration for third party modules
before they are included. Here is an example for `spdlog`:

.. code-block::

  # -------------------------------------------------------
  # spdlog
  # -------------------------------------------------------

  # We want the spdlog install target to be generated even
  # though we are using it as a submodule. The reason for
  # that is that we want our project to be self contained
  # with all dependencies included.
  set(SPDLOG_INSTALL
      ON
      CACHE BOOL "Generate the spdlog install target")

  set(SPDLOG_FMT_EXTERNAL
      ON
      CACHE BOOL "Use external fmt library instead of bundled")

  if(WIN32)
    set(SPDLOG_WCHAR_SUPPORT
        ON
        CACHE BOOL "Support wchar api")
    set(SPDLOG_WCHAR_FILENAMES
        ON
        CACHE BOOL "Support wchar filenames")
  endif()

  add_subdirectory(spdlog)

This approach also works well and is the preferred approach for modules that use
CMake as their build system. It does however require some familiarity with git
submodules.

.. tip::

  Visit the `Git Submodule Tutorial
  <https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial>`_.

Git configuration
-----------------

To make the work with git submodules more reliable, it is strongly recommended
to have the following git configuration setup:

.. prompt:: shell, $

  git config --global diff.submodule log
  git config --global status.submoduleSummary true

Adding a git submodule
----------------------

Adding submodules is easy:

.. prompt:: shell, $

  git submodule add https://github.com/gabime/spdlog.git

This will have created a .gitmodules in the project directory if none already
exists. Future cloning of the project will automatically add the submodules
while fetching the project repo.

By default, submodules will add the sub-project into a directory named the same
as the repository, in this case `spdlog`. You can add a different path at the
end of the command if you want it to go elsewhere.

Finally we can commit the changes.

.. prompt:: shell, $

  git commit -m "Added submodules"

Grabbing updates
----------------

When pulling updates from the container repo's remote, Git auto-fetches, but
does not auto-update. The local cache is up-to-date with the submodule’s remote,
but the submodule’s working directory stays with its former contents. Although
this auto-fetching is limited to already-known submodules: any new ones, not yet
copied into local configuration, are not auto-fetched.

If you don’t explicitly update the submodule’s working directory, your next
container commit will regress the submodule. Is is therefore mandatory that you
finalize the update.

.. prompt:: shell, $

  git pull
  git submodule sync --recursive
  git submodule update --init --recursive

Deleting git submodules
-----------------------

To remove a submodule you need to:

1. Delete the relevant section from the `.gitmodules` file.
2. Stage the .gitmodules changes:

   .. prompt:: shell, $

      git add .gitmodules

3. Delete the relevant section from `.git/config`.
4. Remove the submodule files from the working tree and index:

   .. prompt:: shell, $

      git rm --cached path_to_submodule (no trailing slash).

5. Remove the submodule's `.git` directory:

   .. prompt:: shell, $

      rm -rf .git/modules/path_to_submodule

6. Commit the changes:

   .. prompt:: shell, $

      git commit -m "Removed submodule <name>"

7. Delete the now untracked submodule files:

   .. prompt:: shell, $

      rm -rf path_to_submodule
