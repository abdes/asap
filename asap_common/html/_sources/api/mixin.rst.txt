.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

*********************
Mixin support library
*********************

.. doxygenfile:: mixin.h
   :sections: detaileddescription

The mixin class
===============

.. doxygenstruct:: asap::mixin::Mixin
   :members:

Interfaces and mixins
=====================

When it comes to mixing interfaces in a composite class, we have two options:

1. Implement the interface in a mixin that gets mixed in.

2. Mix a mixin that provides the interface and implement it in the composite
   class.

Mixin implements interface
--------------------------

A mixin must derive from its only template parameter but can also derive from
any other base class. This property can be exploited to implement an interface
inside a mixin. This is particularly useful when the entire interface makes
sense to be implemented in a single place.

Mixin provides interface
------------------------

Often, the interface API is too big to be implemented in a single mixin. In such
case, we can provide the interface to the composite class via a mixin and
implement its API in any suitable way. The challenge with this is the fact that
we require a mixin to have a single template parameter. To solve this challenge
we use a helper that can curry multiple template parameters and a special mixin
`Provides` that uses the curry helper to provide an interface class to the
composite.

.. doxygenstruct:: asap::mixin::Curry

.. doxygenstruct:: asap::mixins::Provides
