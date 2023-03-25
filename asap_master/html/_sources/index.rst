.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

###################
ASAP documentation!
###################

.. |date| date::

Last Updated on |date|

.. toctree::
   :maxdepth: 2
   :titlesonly:
   :hidden:

   getting-started/index
   project-development/index
   documentation/index
   library-modules/index
   tools/index
   license
   changelog.md
   version

Welcome! This is the documentation for the *asap* project. This is the top level
container project for the asap modules. It provides the integrated build system
and the overall structure for projects following the asap development workflow.

The main goal from this family of modules and projects is to significantly cut
the bootstrap time of starting a new c++ application, using CMake as the build
system.

Parts of the documentation
==========================

:doc:`Getting Started! <getting-started/index>`
-----------------------------------------------

*start here to understand how to use this project as a starter for your own
project*

:doc:`Project Development <project-development/index>`
------------------------------------------------------

*refer to this part of the documentation to understand the build system
specifics for this project, the development workflow, coding and unit testing
guidelines*

:doc:`Documentation <documentation/index>`
------------------------------------------

*refer to this part of the documentation to understand how project documentation
is structured and built from source using `doxygen` and `sphinx`.*

:doc:`Library Modules <library-modules/index>`
----------------------------------------------
*check this out to explore the different modules part of this project. From
there, you can also jump to the detailed API documentation of each of those
modules.*

:doc:`Project Tools <tools/index>`
----------------------------------
*get an introduction to the programs and scripts under the `tools` folder,
specifically made for the `asap` project. These can simplify recurring tasks and
provide additional insights into the project, and sometimes examples of how to
use the project artifacts.*

Acknowledgements
================

.. figure:: https://executablebooks.org/en/latest/_static/logo-wide.png
  :figclass: margin
  :alt: Executable Books Project
  :name: executable_book_logo

This documentation uses the theme provided by the `Executable Books Project
<https://executablebooks.org/>`_ Project.
