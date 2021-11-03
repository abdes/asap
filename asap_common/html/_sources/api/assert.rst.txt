Assertions
==========

Header file <common/assert.h> provides a number of macros that can be used to
implement assertions in C++ code.

.. doxygendefine:: ASAP_ASSERT_PRECOND

.. doxygendefine:: ASAP_ASSERT

.. doxygendefine:: ASAP_ASSERT_VAL

.. doxygendefine:: ASAP_ASSERT_FAIL

.. doxygendefine:: ASAP_ASSERT_FAIL_VAL

.. note::

   The behavior of the assertion macros can be controlled through the
   :ref:`feature-symbols` defined in <common/config.h>:
