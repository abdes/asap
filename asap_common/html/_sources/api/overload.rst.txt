.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

********************
The overload pattern
********************

The header <common/overload.h> implements the useful overload pattern, which
allows to use separate lambdas "in=place" for visiting a variant. Traditionally
lambdas can not be implicitly overloaded.

In C++14 you could derive from lambdas and build similar helper types, but only
with C++17 you can significantly reduce boilerplate code and limit potential
errors. With C++20 we’ll get even shorter syntax as CTAD (*Class Template
Argument Deduction*) will work with aggregates.

You can read more in the proposal for overload `P0051
<https://wg21.link/P0051>`_ (it was not accepted for C++20, but it’s worth to
see discussions and concepts behind it).

.. doxygenstruct:: asap::Overload
