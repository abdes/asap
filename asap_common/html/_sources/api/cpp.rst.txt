.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for subsubsections
     " for paragraphs

********************
C++ language helpers
********************

Singleton class
===============

The header <common/singleton.h> declares the class :class:`asap::Singleton`.

.. doxygenclass:: asap::Singleton
   :members:
   :protected-members:

Class :class:`asap::Singleton` provide a base class that can be used to implement concrete singleton
classes. A singleton is a class for which only one instance can exist in the process.
