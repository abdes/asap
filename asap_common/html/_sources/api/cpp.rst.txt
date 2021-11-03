C++ language helpers
====================

Non copiable class
------------------

The header <common/non_copyable.h> defines the class
:class:`asap::NonCopiable`.

.. doxygenclass:: asap::NonCopiable
   :members:
   :protected-members:

Class :class:`asap::NonCopiable` has protected constructor and destructor
members to emphasize that it is only intended to be inherited from. Both use
the C++ 11 trivial implementation by marking them ``default``.

Logical traits
--------------

The header <common/traits/logical.h> defines equivalent of the C++ 17 logical
operations on type traits, reducing the requirement to just C++ 14.

.. doxygenstruct:: asap::conjunction

.. doxygenstruct:: asap::disjunction

.. doxygenstruct:: asap::negation

.. seealso::

   `std::conjunction <https://en.cppreference.com/w/cpp/types/conjunction>`_
      Documentation of the standard C++ conjunction operation.

   `std::disjunction <https://en.cppreference.com/w/cpp/types/disjunction>`_
      Documentation of the standard C++ disjunction operation.

   `std::negation <https://en.cppreference.com/w/cpp/types/negation>`_
      Documentation of the standard C++ negation operation.

Helper variables for C++ 14 and above
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If the C++ compiler provides support for C++ 14 or above, the following two
helper variables are also defined:

.. code-block:: c++

   template <class... Bi>
   constexpr bool conjunction_v = conjunction<Bi...>::value;

   template <class... Bi>
   constexpr bool disjunction_v = disjunction<Bi...>::value;

   template <class B>
   constexpr bool negation_v = negation<B>::value;

