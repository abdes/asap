.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

###########
Get Started
###########

.. |date| date::

Last Updated on |date|

.. toctree::
   :maxdepth: 1
   :titlesonly:
   :hidden:

   devenv
   get-the-code
   structure
   useful-commands
   customizing
   get-updates

You chose to get started with `asap` and you made the right choice. This part of
the documentation will help you quickly get started. But before you start, here
are a couple of tips and answers to some frequently asked questions:

#. **What platform can I use to do the development of an `asap` based project?**

   You can clone and use the `asap` project on Windows, macOS and Linux. Most of
   the features will be working just fine but some features may require a
   specific compiler or development tool that is available only on a specific
   operating system.

   There is a recommended setup that is described in detail in the :doc:`Getting
   ready for C++ development <devenv>` document.

#. **What compilers and debuggers can I use?**

   You can use You `GCC <https://gcc.gnu.org>`_-based compilers, `Clang
   <https://clang.llvm.org>`_ and `Visual Studio C++ compiler
   <https://visualstudio.microsoft.com/>`_.

#. **Do I need to install anything in advance?**

   Yes. Refer to :doc:`Getting ready for C++ development <devenv>` document for
   a complete and detailed guide.

#. **Can I use `asap` with my favorite IDE?**

   Definitely. However to get the maximum out of it your IDE should have some
   level of support of and integration with `CMake`.


:doc:`Getting ready for C++ development <devenv>`
-------------------------------------------------

*at the minimum you need a terminal program, a C++ compiler and a text editor,
but we're here for maximum productivity and pleasure while coding. Start here to
understand the recommended tooling and the rationale behind some of the
important choices made in `asap`.*

:doc:`Creating the project <get-the-code>`
-------------------------------------------------

*with the development environment in place, you're ready to start working on
your project. Follow this guide to get the `asap` code.*

:doc:`Understanding the project structure <structure>`
------------------------------------------------------

*the project structure follows best practices to implement multi-module projects
that maintain clean dependencies, easily integrate 3rd party libraries and use
cmake in an as simple as possible way. You can learn more about it here.*

:doc:`Useful commands <useful-commands>`
------------------------------------------------------

*when using this starter project to build your own project, you might follow the
instructions in this guide to customize it to fit your needs or your
organization's policies and style.*


:doc:`Make it your own <customizing>`
------------------------------------------------------

*when using this starter project to build your own project, you might follow the
instructions in this guide to customize it to fit your needs or your
organization's policies and style.*

