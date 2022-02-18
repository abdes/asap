.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

###############
Library Modules
###############

.. toctree::
   :maxdepth: 2
   :titlesonly:
   :hidden:

   Module: common <https://abdes.github.io/asap/asap_common/html/>
   Module: contract <https://abdes.github.io/asap/asap_contract/html/>

The `asap` projects comes with two built-in modules, offering some core basic
functionality:

:doc:`common <common:index>`
============================
  *offers some core and low level features such as platform/environment
  detection and C++ language features not consistently provided by all
  compilers on all platforms.*

:doc:`contract <contract:index>`
================================
  *a lightweight implementation of contract checking assertions, while
  waiting for it to potentially become a standard feature in C++-23 or later.*
