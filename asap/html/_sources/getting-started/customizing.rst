.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

.. _make-it-your-own:

****************
Make it your own
****************

.. |date| date::

Last Updated on |date|

We've already seen in :ref:`get-the-code`, the first step of making `asap` your
own, that is renaming your fork to suit your project. There are many more things
you may want to change or adjust to suit your needs.

Project information
===================

Project meta information such as its name, repo, author, etc. are located in the
main `CMakeLists.txt` file. Edit that file to change the information as depicted
below:

.. code:: cmake

  set(META_PROJECT_NAME        "my-project")
  set(META_PROJECT_DESCRIPTION "A super cool project started with `asap`")
  set(META_AUTHOR_ORGANIZATION "My Company")
  set(META_GITHUB_REPO         "https://github.com/me/my-project")
  set(META_AUTHOR_DOMAIN       "https://www.my-company.com")
  set(META_AUTHOR_MAINTAINER   "Me MySelf and I")
  set(META_VERSION_MAJOR       "1")
  set(META_VERSION_MINOR       "0")
  set(META_VERSION_PATCH       "0")

For now, you don't need to change anything else in the `CMakeLists.txt` file.
Later, you may need to add submodules, add `CMake` actions, change some of the
logic in the `CMake`` build etc. as you wish. Some of these activities will be
the subject of dedicated chapters in this guide.

Additional files that need to be adapted to your project include:

- AUTHORS
- LICENSE
- README.md
- CHANGELOG.md (which needs to be cleared to prepare for the first time you will
  release your forked project.

Deployment package
==================

.. todo::

  Add instructions for customizing the content of the `deploy` directory.

Tools configuration files
=========================

There are several files in the project which are used to configure the various
tools used in the development lifecycle. While the provided configuration aims
at implementing the best practices, you may want to change it for personal
preference, organization policies, reasons, etc.

The following list describes the available files and their usage:

:.gitattributes: The .gitattributes file allows you to specify the files and
  paths attributes that should be used by git when performing git actions, such
  as git commit, etc.

  In other words git automatically saves the file according to the attributes
  specified, every time a file is created or saved.

  One of these attributes is the eol (end of line) and is used to configure the
  line endings for a file. This article will now dive deeper into how to
  configure the line endings, so every developer uses the same value when using
  different machines / OSes across the repository.

:.gitignore: The purpose of gitignore files is to ensure that certain files not
  tracked by Git remain untracked.

:.versionrc.json: `standard-verion <https://github.com/conventional-changelog/standard-version>`_
  rules and configuration options.

:.commitlintrc.json: Rules used to validate the commit message used during git
  commits.

:.cmake-format.yaml: Configuration rules for the `cmake-format
  <https://github.com/cheshirekow/cmake_format>`_ tool.

:.clang-tidy: `Clang-tidy <https://clang.llvm.org/extra/clang-tidy/>`_ rules
  used for linting the C++ source code.

:.clang-format: `Clang-format <https://clang.llvm.org/extra/clang-format/>`_
  rules used for formatting the C++ source code.

Documentation
=============

.. hint::
  :class: margin

  `asap` uses `Doxygen Awesome
  <https://jothepro.github.io/doxygen-awesome-css/>`_ and `Executable Book
  <https://sphinx-book-theme.readthedocs.io/en/latest/index.html>`_ themes for
  `doxygen` and `sphinx` respectively.

  Apart from the need to document your own project files, you may also want to
  change the themes used by `doxygen` or `sphinx` when generating the HTML
  documentation.

The `asap` project comes with an extensive set of documents that you can keep
part of your new project or change them as you wish.

At a minimum, you need to replace the icon and the logo of the project with your
own. They are both located in the ```doc/_static``` directory. You also need to
change the ```README.md``` file content to adapt it to your new project.
