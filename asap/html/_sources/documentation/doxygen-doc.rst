.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

****************
Documenting code
****************

.. |date| date::

Last Updated on |date|

Writing documentation
=====================

Doxygen uses special comment blocks that contain documentation directives.
Multiple styles are supported by doxygen for these special comment blocks, and
you can use any of them. It is strongly recommended however to stick to a single
style for the entirety of your code base.

.. tip::

  Check the `Doxygen documentation
  <https://www.doxygen.nl/manual/starting.html>`_ for detailed information on
  how doxygeen works.

Themes and styling the documentation
====================================

The project uses `Doxygen Awesome
<https://jothepro.github.io/doxygen-awesome-css/>`_ theme which generates
functional and awesome looking HTML documentation. It can be customized to fit
your needs.

All the configuration files for `doxygen` are located in the `doxygen` directory
under the project root.

Building the documentation
==========================

For consistency reasons, the documentation build uses CMake similar to what is
done for the source code and related artifacts. Specific targets are defined for
generating the *API** documentation using `doxygen`.

From within the `build` directory, use the following commands to generate the
documentation:

.. prompt:: bash $,(env)...$ auto

  $ cmake --build . --target dox

The generated documentation in `HTML` will be available under the folders `dox`
as shown below:

.. code-block:: text

  ...\_BUILD\DOX
  ├───asap_common
  │   ├───html
  │   └───xml
  └───asap_logging
      ├───html
      └───xml
