.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for subsubsections
     " for paragraphs

********************************
Masks/Flags manipulation helpers
********************************

The header <common/flag_ops.h> defines a number of helper template functions 
to set, clear, flip, and test flags in a bitset mask. All these functions
can only be instantiated with an arithmetic type (e.g. int) or an enum type.

  * :ref:`FlagSet <FlagSet>`
  * :ref:`FlagClear <FlagClear>`
  * :ref:`FlagFlip <FlagFlip>`
  * :ref:`FlagTest <FlagTest>`

.. _FlagSet:

.. doxygenfunction:: asap::FlagSet

.. _FlagClear:

.. doxygenfunction:: asap::FlagClear

.. _FlagFlip:

.. doxygenfunction:: asap::FlagFlip

.. _FlagTest:

.. doxygenfunction:: asap::FlagTest
