.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for subsubsections
     " for paragraphs

******************
Compiler detection
******************

The `common` module provides a set of macros that help in dealing with the various compilers that 
may be used to build the software. These macros come in 4 categories:

- `Identification`_
- `Version checking`_
- `Feature testing`_
- `Diagnostics`_
- `Optimization hints`_

Identification
==============

These macros are defined only if the compiler in question is in use (e.g., ASAP_MSVC_VERSION is only
defined when using the MSVC compiler). When they are defined, they are defined to the version of the
compiler currently in use, encoded into a single integer.

This provides a uniform way to check the if a specific compiler is in use, as well as determine the 
version.

Note that the GCC and GNUC macros are different. Many compilers masquerade as GCC (by defining 
__GNUC__, __GNUC_MINOR__, and __GNUC_PATCHLEVEL__, but often do not implement all the features that 
the version of GCC they pretend to be supports. To work around this, the ASAP_GCC_VERSION macro is 
only defined for GCC, whereas ASAP_GNUC_VERSION will be defined whenever a compiler defines 
__GNUC__.

.. doxygendefine:: ASAP_CLANG_VERSION

.. doxygendefine:: ASAP_MSVC_VERSION

.. doxygendefine:: ASAP_GNUC_VERSION

.. doxygendefine:: ASAP_GCC_VERSION

Version checking
================

For each compiler for which there is a ASAP_*_VERSION macro, there is a 
ASAP_*_VERSION_CHECK(major,minor,revision) macro. These macros are always defined, and will return 
true (1) if the current compiler corresponds to the macro name, and the compiler version is greater 
than or equal to the provided values.

This provides a convenient way to check for features based on the version number.

.. doxygendefine:: ASAP_CLANG_VERSION_CHECK

.. doxygendefine:: ASAP_MSVC_VERSION_CHECK

.. doxygendefine:: ASAP_GNUC_VERSION_CHECK

.. doxygendefine:: ASAP_GCC_VERSION_CHECK

Feature testing
===============

`Clang`` introduced an easier way to detect different features which doesn't rely on knowledge of 
the version number it first appeared in. Not only is this the preferred method for checking for 
features in `clang`, it's pretty much the only way!

Many clang-based compilers implement these macros, including Apple. Additionally, some
non-clang-based compilers support a subset of the macros.

Attributes
----------

.. doxygendefine:: ASAP_HAS_ATTRIBUTE

.. doxygendefine:: ASAP_HAS_CPP_ATTRIBUTE


Builtin functions
-----------------

.. doxygendefine:: ASAP_HAS_BUILTIN

Features
--------

.. doxygendefine:: ASAP_HAS_FEATURE

Diagnostics
===========

.. doxygendefine:: ASAP_PRAGMA

.. doxygendefine:: ASAP_DIAGNOSTIC_PUSH

.. doxygendefine:: ASAP_DIAGNOSTIC_POP

.. doxygendefine:: ASAP_HAS_WARNING

Optimization hints
==================

.. doxygendefine:: ASAP_ASSUME

.. doxygendefine:: ASAP_UNREACHABLE

.. doxygendefine:: ASAP_UNREACHABLE_RETURN
