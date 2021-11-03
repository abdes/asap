.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for subsubsections
     " for paragraphs

*******************
ASAP documentation!
*******************

.. toctree::
   :maxdepth: 2
   :titlesonly:
   :hidden:

   01-getting-started/index
   02-developer-guides/index
   03-library-modules/index
   license
   changelog.md

Welcome! This is the documentation for the *asap* project. This is the top level
container project for the asap modules. It provides the integrated build system
and the overall structure for projects following the asap development workflow.

The main goal from this family of modules and projects is to significantly cut
the bootstrap time of starting a new c++ application, using CMake as the build
system.

Parts of the documentation
==========================

:doc:`Getting Started! <01-getting-started/index>`
--------------------------------------------------
*start here to understand how to use this project as a starter for your own
project*

:doc:`Developer Guides <02-developer-guides/index>`
---------------------------------------------------
*refer to this part of the documentation to understand the build system
specifics for this project, the development workflow, coding and unit testing
guidelines*

:doc:`Library Modules <03-library-modules/index>`
-------------------------------------------------
*check this out to explore the different modules part of this project. From
there, you can also jump to the detailed API documentation of each of those
modules.*

Indices and tables
==================

  | :ref:`genindex`
  | :ref:`search`

Meta information
================

This documentation was generated from version: |release|.

  | :doc:`License <license>`
