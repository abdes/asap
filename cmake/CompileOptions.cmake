# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Set additional common compiler options and warning flags
# ------------------------------------------------------------------------------
#
# Refer to swift_set_compile_options() for additional detailed information on
# accepted options for this function, which forwards all options.
#
# In addition to relaying the call, this function adds common compiler options
# and overrides the default behavior of swift with regard to exceptions and
# RTTI. By default, both are enabled.

function(asap_set_compile_options)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    # using Clang
    swift_set_compile_options(
      ADD
      -Weverything
      -Wno-c++98-compat
      -Wno-c++98-compat-pedantic
      -Wno-c++98-c++11-compat-pedantic
      -Wno-padded
      -Wno-documentation-unknown-command
    )
    # -Wno-switch-enum -Wno-unused-macros -Wno-disabled-macro-expansion)
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # using GCC
    swift_set_compile_options(
      ADD
      -Wctor-dtor-privacy
      -Winit-self
      -Wmissing-declarations
      -Wold-style-cast
      -Woverloaded-virtual
      -Wsign-conversion
      -Wsign-promo
      -Wundef
    )
    if(NOT DEFINED CMAKE_CXX_CLANG_TIDY)
      swift_set_compile_options(ADD -Wlogical-op -Wstrict-null-sentinel)
    endif()
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    # using Visual Studio C++
    set(argOption "WARNING")
    set(argSingle "")
    set(argMulti "")

    cmake_parse_arguments(x "${argOption}" "${argSingle}" "${argMulti}" ${ARGN})

    set(targets ${x_UNPARSED_ARGUMENTS})

    foreach(target ${targets})
      target_compile_options(
        ${target}
        PRIVATE
          /EHsc
          /MP
          /W4
      )
      if(NOT x_WARNING)
        target_compile_options(${target} PRIVATE /WX)
      endif()
      # Enable coverage profiling in Debug builds (see
      # https://github.com/abdes/asap/issues/22)
      target_link_options(${target} PRIVATE $<$<CONFIG:Debug>:/PROFILE>)
    endforeach()
  endif()
endfunction()

# ------------------------------------------------------------------------------
# Clean compiler settings and options
# ------------------------------------------------------------------------------

if("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
  # remove default warning level from CMAKE_CXX_FLAGS_INIT CMake adds compiler
  # warning levels by default and for MSVC, it uses /W3 which we want to
  # override with /W4. The override does make MSVC complain though, so we just
  # strip any argument already added by cmake before we set ours.
  string(REGEX REPLACE "/W[0-4]" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif()
