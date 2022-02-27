.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

.. _project-structure:

********************************
Understand the project structure
********************************

.. |date| date::

Last Updated on |date|

Compared to other languages such JavaScript, Java or Rust, C++ seriously lacks
built-in capabilities for defining, building and using modules. Many competing
approaches exist such as `Conan <https://conan.io/>`_, `vcpkg
<https://vcpkg.io/>`_, `Hunter <https://github.com/cpp-pm/hunter>`_, etc. None
of them completely solves the problem and the worst part is that they often are
mutually exclusive.

The choices made in the `asap` starter project with regard to the project layout
and to how modules (internal and 3rd party) are integrated and managed do not
exclude the use of package managers or lock you down to one approach or another.

The emphasis is put on a clean and extensible project layout and a build system
that stays as much as possible within the commonly used things in CMake.

Software Architecture: The Module Viewtype [#f1]_
=================================================

Decomposing a system into manageable units remains one of the most common ways
to think about the structure of the system. Often, it also determines how a
system's source code is partitioned into separate parts, what kind of interfaces
exist between these parts and how these parts are aggregated into larger
ensembles.

In the context of `asap` we adopt a broad definition of the `module` concept as
an implementation unit of software that provides a coherent unit of
functionality. Because we are dealing specifically with C++ development, that
implementation unit will be a set of C++ files, configuration files, static data
files, etc. In addition to that,we also deal with documentation files, and
various build scripts, including CMake and other tools.

Modules can be related to each others in different ways:

- **A is part of B**: this type of relation can indicate simple aggregation,
  such as when a module is included into one or many others, or could indicate a
  more sophisticated decomposition relationship.
- **A depends on B**: this relation can take several forms such as uses,
  allowed-to-use, sends-data-to, transfers-control-to, and so forth.
- **A is a B**: this one defines a generalization relationship and in general
  would not impact the macro-level structure of the project. We do however use
  it in this starter project to define library and executable modules for which
  we provide generic reusable CMake build scripts that can be simply extended.

To the maximum possible extent we want to preserve and faithfully map the
modules and their relations in the software architecture to the development
infrastructure. Implementing a module always results in many separate files,
such as those that contain the source code, files that have to be included and
usually contain definitions, files that describe how to build an executable, and
files that are the result of translating, or compiling, the module. Those files
need to be organized so as not to lose control and integrity of the system.
Configuration management techniques usually do this job: in the simplest case, a
hierarchy of directories in a file system.

Assuming this starter project is used to build a simple application that reads
and writes files on the local filesystem, a representation of the application
architecture in a module decomposition view would look like this:

.. code-block:: text

    ┌─────────────────────────────────────────────────────────────────┐
    │ ASAP Application                                                │
    │  (System)                                                       │
    │  ┌─────────────────────┐                          ┌──────────┐  │
    │  │                     ├──────────────────────────►          │  │
    │  │                     │                          │          │  │
    │  │                     │  ┌───────────────────┐   │          │  │
    │  │                     │  │                   │   │          │  │
    │  │                     │  │ logging framework │   │          │  │
    │  │                     │  │                   │   │          │  │
    │  │                     │  │               3PM │   │          │  │
    │  │                     │  └───────────▲───────┘   │          │  │
    │  │                     │              │           │          │  │
    │  │       Main          │              │           │          │  │
    │  │                     │  ┌───────────┴───────┐   │          │  │
    │  │    Application      │  │  common           │   │          │  │
    │  │                     │  │                   │   │          │  │
    │  │       Module        │  │                   │   │          │  │
    │  │                     ├──►                   ├───►          │  │
    │  │                     │  │                   │   │   unit   │  │
    │  │                     │  │                   │   │          │  │
    │  │                     │  └───▲───────────────┘   │  testing │  │
    │  │                     │      │                   │          │  │
    │  │                     │  ┌───┴───────────────┐   │ framework│  │
    │  │                     │  │                   │   │          │  │
    │  │                     ├──►  other module     ├───►          │  │
    │  │                     │  │                   │   │          │  │
    │  │                     │  │                   │   │      3PM │  │
    │  └─────────────────────┘  └───────────────────┘   └──────────┘  │
    │                                                                 │
    └─────────────────────────────────────────────────────────────────┘

.. note::
  :class: margin

  Composition is allowed at any depth within the structure of an `asap` based
  project. Often, it is implemented using a `git` submodule.

The arrow in the diagram above mainly refer to a uses relationship. Notice how
the modules can be 3rd party modules (indicated with a `3PM` sticker), provided
by `asap` as reusable components or specifically made for the application.

The `Unit Testing Framework` is extensively used in the project but only during
development. It won't be part of the final application package for deployment
for instance. Such modules exist within the project and the CMake build system
can clear make the difference between the artifacts intended for use during
development only vs. the ones destined for deployment.

Project Layout
==============

Based on the module decomposition view above, we now can look at how this
translates into the hierarchy of directories forming the `asap` project layout.

.. code-block:: text

     .
     ├── <.git>                          I
     ├── <.sphinx>
     ├── <build>
     │   ----------------------------------------
     ├── <.github>
     ├── <.husky>
     ├── <.vscode>
     ├── <doxygen>                       II
     ├── .clang-format
     ├── .clang-tidy
     ├── .commitlintrc.json
     ├── .gitattributes
     ├── .gitignore
     ├── .gitmodules
     ├── .runsettings
     ├── .versionrc.json
     ├── requirements.txt
     │   ----------------------------------------
     ├── <doc>                           III
     │   ----------------------------------------
     ├── <deploy>                        IV
     │   ----------------------------------------
     ├── <data>                          V
     │   ----------------------------------------
     ├── <templates>                     VI
     │   ----------------------------------------
     ├── <common>
     ├── <filesystem>
     ├── <third_party>                   VII
     │   ├── <fmt>
     │   ├── <spdlog>
     │   └── CMakeLists.txt
     │   ----------------------------------------
     ├── <cmake>
     ├── CMakeLists.txt                  VIII
     ├── asap-config.cmake
     │   ----------------------------------------
     ├── AUTHORS
     ├── LICENSE                          IX
     ├── README.md
     └── CHANGELOG.md

The above diagram shows a typical layout with directories and files of a startup
project based on asap. The actual files and directories will of course differ
from project to project based on how you customize it to add or remove things
from the starting state.

The files and directories have been grouped into clusters based on their common
purpose. We'll explain what each cluster role is and what are the important
directories and files it contains.

.. list-table::
  :widths: 10 90
  :header-rows: 1

  * - Part
    - Description

  * - I
    - Transient directories created by the various tools used during the
      development. Items other than the `.git` directory will not be present
      when the project is freshly cloned. The `.sphinx` directory holds the
      python virtual env used for the documentation generation. The `build`
      directory is where the `cmake` build will happen and all build artifacts
      will be located.

  * - II
    - Various files used to configure and customize the behavior of tools used
      in the development. Their usage will be explained in the corresponding
      sections of the documentation.

  * - III
    - This is where all project documentation resides. The documentation system
      primarily uses `sphinx` and `restructuredText` but occasionally markdown
      files can also be used. Maintaining the project documentation is an
      important task which will be thoroughly explained separately.

  * - IV
    - This directory holds data and configuration files required to build the
      final deployable package of the project artifacts. These packages are
      often operating system dependent.

  * - V
    - This directory is intentionally present in the starter project even if no
      data is inside to emphasize the best practice of separating application
      data from code, configuration, etc... Use this place to store static data
      files that need to be deployed with the system.

  * - VI
    - System wide templates used during the build to generate other files. If a
      template is only used within a specific module, place it within its
      corresponding module.

  * - VII
    - The various modules in the system. Third party libraries are preferably
      placed under the `third_party` directory for clear demarcation of what is
      coming from outside the project. Sometimes, it is more natural or
      practical to embed the third party code directly within the source code of
      a system module (e.g. this is how Hedley is included inside the `common`
      module).

  * - VIII
    - The CMakeLists.txt and supported scripts which are used to build the
      system deployable artifacts from source code. Customization of the starter
      project build to suit the real project happens primarily in the
      `CMakeLists.txt` and `asap-config.cmake` files. All files under the
      `cmake` directory are generic reusable scripts and, in general, should not
      be modified.

  * - IX
    - Various meta-information files present in each project repository. Adapt
      the contents as needed to suit your project, keeping in mind the
      `CHANGELOG.md` can be automatically maintained as described in this
      documentation.


General Layout of a C++ source Module
=====================================

Since we are heavily using the system decomposition into modules as an
architectural principle, we'll be creating a lot of these modules and therefore
we need to be consistent and efficient in how we layout the source code
artifacts inside each one of them.

I have looked at so many OpenSource projects, coding standards, recommended
project layouts,... for inspiration and while there is no holy grail for this
problem, a few best practices have emerged:

- separate test code from the module functional code. That way, it is clear
  which files contribute to build the module deployable artifacts vs. testing
  artifacts.
- we're doing C++, so we have interface files (.h) and implementation files
  (.cpp) and while there is no consensus on where to put them, I have found
  that it is much simpler and cleaner to keep them each in its own directory.
  With modern editors, we don't navigate code anymore based on the file browser.
  We use intellisense.
- inside the `include` directory, repeat the module name so that when we include
  files from this module we say `#include <module/foo.h>` and not `<foo.h>`.
  In coding, explicit intents are much safer than implicit intents.
- in-house developed modules containing C++ code are much easier reused in their
  source code form than in any other form. Unfortunately C++ package managers
  are still far from mature. Therefore, we keep each module in its own git
  repository and we embed it as a submodule when reused.
- building a module should be descriptive. The build logic and complexity should
  already be managed at the system level. We just need to describe a module to
  get it included in the system. That description is in the module's
  `CMakeLists.txt` which almost does not contain any scripted logic.
- each module should be properly documented. The system documentation build will
  ensure modules can be referred to and get integrated into the overall
  documentation.

With these in mind, the layout of each module looks like this:

.. code-block:: text

  │   .gitignore
  │   .gitmodules
  │   AUTHORS
  │   CMakeLists.txt
  │   LICENSE
  │   README.md
  │
  ├───doc
  │
  ├───include
  │   ├───common
  │   │   └───traits
  │   └───contracts
  │
  ├───src
  │
  └───test


.. rubric:: Footnotes

.. [#f1] An excellent book on this topic is `Documenting Software Architectures:
   Views and Beyond <https://www.amazon.com/Documenting-Software-Architectures-Views-Beyond/dp/0201703726/ref=sr_1_1?_encoding=UTF-8&camp=212361&creative=380601&dchild=1&keywords=0201703726&link_code=wql&qid=1635883655&s=books&sr=1-1>`_
   (available on Amazon, or just Google it).
