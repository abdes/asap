.. Structure conventions
# with overline, for parts
* with overline, for chapters
= for sections
- for subsections
^ for sub-subsections
" for paragraphs

*****************
Contract checking
*****************

Contracts are usually expressed in the form of preconditions, post-conditions
and assertions. Some programming languages have built-in support for contracts.
So far, the closest in C++ is assertions. But assertions are not expressive and
are not consistent. This simple API is intended at offering some rudimentary
support of contract programming in the form of preconditions, post-conditions
and assertions with three levels of contract enforcement at build time: `off`,
`default` and `audit`, while waiting for it to become part of the C++ language
in a near future.

Alternative libraries and references
====================================

- `Contract Checking in C++: A (long-term) Road Map
  <http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p1332r0.txt>`_.

- `libcontract <https://github.com/alexeiz/contract>`_ Library to support
   contract programming in C++11.

- `Boost.Contract
  <https://www.boost.org/doc/libs/1_78_0/libs/contract/doc/html/index.html>`_
  implements contract programming (a.k.a., Design by Contract or DbC) [1] for
  the C++ programming language..

- `N3753 <http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2013/n3753.pdf>`_,
  "Centralized Defensive-Programming Support for Narrow Contracts" proposed for
  C++14 Standard.

- `N1962 <http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2006/n1962.html>`_,
  "Proposal to add Contract Programming to C++ (revision 4)" (not adopted for
  C++11 Standard).

Contract checking macros
========================

There are three contract checking modes that can be set at build time by
defining the appropriate symbol. Each mode has a specific behavior for the
contract checking at runtime as described in the table below:

.. list-table::
  :header-rows: 1
  :widths: 15 30 55

  * - Build mode
    - Symbol to be defined
    - Behavior

  * - OFF
    - ASAP_CONTRACT_OFF
    - None of the conditions are enforced.

  * - DEFAULT
    - ASAP_CONTRACT_DEFAULT
    - Default mode conditions are enforced and execution will abort if the
      contract is not honored. Audit mode conditions are ignored.

  * - AUDIT
    - ASAP_CONTRACT_AUDIT
    - All conditions are enforced and execution will abort if the contract is
      not honored.

Default mode macros
-------------------

.. doxygendefine:: ASAP_EXPECT

.. doxygendefine:: ASAP_ENSURE

.. doxygendefine:: ASAP_ASSERT

Audit mode macros
-------------------

.. doxygendefine:: ASAP_EXPECT_AUDIT

.. doxygendefine:: ASAP_ENSURE_AUDIT

.. doxygendefine:: ASAP_ASSERT_AUDIT

Violation Handler
=================

There is a single violation handler in the system. Its implementation, however,
can be switched at runtime to install a custom handler.

.. doxygenfunction:: GetViolationHandler

.. doxygenclass:: asap::contract::ViolationHandler
   :members:

Unit testing contracts
======================

Testing contracts is tricky as violations often result in the program execution
being abruptly terminated rendering it quite difficult to test without death
test support by the testing framework.

To simplify this situation, you can use the special macros for testing contracts
without death tests.

.. doxygendefine:: CHECK_VIOLATES_CONTRACT

.. doxygendefine:: EXPECT_VIOLATES_CONTRACT

.. doxygendefine:: ASSERT_VIOLATES_CONTRACT

Example
-------

.. code-block:: c++

  // Some function to be tested in some .cpp file
  auto TestExpectDefault(const int *ptr) -> int {
    ASAP_EXPECT(ptr);
    return *ptr;
  }

.. code-block:: c++

  #include "contract/ut/framework.h"
  #include "contract/ut/gtest.h"

  #include <gtest/gtest.h>

  TEST(GoogleTestDeathMacros, DefaultModeExpectDeath) {
    CHECK_VIOLATES_CONTRACT(testing::TestExpectDefault(nullptr));
  }

  auto main(int argc, char **argv) -> int {
    asap::contract::PrepareForTesting();
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
  }

Limitations
-----------

The mechanism that allows contract checks to be tested during unit tests is
implemented with setjmp and longjmp. It uses global variables to save the stack
environment during the setjmp/longjmp which is not thread safe.
