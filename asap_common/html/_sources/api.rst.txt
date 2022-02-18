.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

*************
API reference
*************

.. toctree::
   :maxdepth: 2
   :hidden:

   Platform detection <api/platform>
   Compiler detection <api/compilers>
   Overload pattern <api/overload>
   Mixin library <api/mixin>
   Mask/Flags manipulation <api/flags>

This module offers the following APIs:

:doc:`Platform detection <api/platform>`
========================================
  *macros and compiler definitions to help identify the platform on which the
  code is being compiled.*

:doc:`Compiler detection <api/compilers>`
=========================================
  *macros and compiler definitions to help identify and use the compiler being
  used to compile the code.*

:doc:`Overload pattern <api/overload>`
======================================
  *the famous overload pattern which allows to use separate lambdas
  "in=place" for visiting a variant.*

:doc:`Mixin library <api/mixin>`
================================
  *a lightweight library to simplify the use of mixins in C++ classes.*

:doc:`Mask/Flags manipulation <api/flags>`
==========================================
  *utility functions to help in using and manipulating bit flags and masks.*
