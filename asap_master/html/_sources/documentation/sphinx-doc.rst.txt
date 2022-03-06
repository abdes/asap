.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

****************************
Sphinx and restructured text
****************************

.. |date| date::

Last Updated on |date|

Setting up the environment
==========================

It is recommended to use a dedicated environment for python and the additional
extensions required for sphinx documentation. Managing python versions and
environments can be done in a multitude of ways. Describing all of them is out
of scope of this documentation. We do however provide instructions for doing so
with Anaconda/Miniconda.

From within the root folder of the project, follow the instructions below:

.. prompt:: bash $,(env)...$ auto

  $ conda create --prefix=./.sphinx python=3.9
  $ conda activate $PWD/.sphinx
  (env)...$ pip install -r requirements.txt

This will have python 3.9 installed in a dedicated environment in the `.sphinx`
directory under the project root. All python modules required to produce the
documentation will be installed and ready to use.

Building the documentation
==========================

For consistency reasons, the documentation build uses CMake similar to what is
done for the source code and related artifacts. Specific targets are defined for
generating the *API** documentation and the *User Manual*.

From within the `build` directory, use the following commands to generate the
documentation:

.. prompt:: bash $,(env)...$ auto

  $ cmake --build . --target dox
  $ cmake --build . --target sphinx

The generated documentation in `HTML` will be available under the folders `dox`
and `sphinx` as shown below:

.. code-block:: text

  ...\_BUILD\DOX
  ├───asap_common
  │   ├───html
  │   └───xml
  └───asap_logging
      ├───html
      └───xml

  ...\_BUILD\SPHINX
  ├───asap_common
  │   └───html
  │       └───api
  ├───asap_logging
  │   └───html
  │       └───api
  └───master
      └───html
