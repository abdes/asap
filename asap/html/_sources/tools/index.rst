.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

#############
Project Tools
#############

.. |date| date::

Last Updated on |date|

.. toctree::
   :maxdepth: 2
   :titlesonly:
   :hidden:

The `tools` directory under the project root holds project-specific tools.
Currently we have:

  * Project version info tool: a simple executable written as a C++ program,
    using the generated `version.h` include file to print the project meta-data
    defined in the project's cmake file.
