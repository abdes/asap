# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Google Sanitizers https://github.com/google/sanitizers
#
# This module simplifies the use of Google Sanitizers (Address, Undefined
# Behavior and Thread) in the build. The Memory sanitizer is not supported
# because it requires all code, including third party and system libraries to be
# built with it.
#
# A target can be instrumented with any of the sanitizers by calling the
# corresponding function with the target name:
# ~~~
#    address sanitizer            : asap_add_google_asan(target)
#    undefined behavior sanitizer : asap_add_google_ubsan(target)
#    thread sanitizer             : asap_add_google_tsan(target)
# ~~~
# NOTES:
#
# ASAN and UBSAN can be run together, but TSAN must be run separately.
#
# Not all compilers support all sanitizers. It is the responsibility of the
# caller to call these functions when the selected compiler does support the
# requested sanitizer. Failure to do so will not abort the CMake generation, but
# will print a message when the compiler does not support the requested
# sanitizer.
#
# ------------------------------------------------------------------------------

# ---- Internal function to check for compiler support of the sanitizer flags --

include(CMakePushCheckState)
include(CheckCXXSourceCompiles)
include(CMakeCheckCompilerFlagCommonPatterns)

function(_check_sanitizer_flags _flag _var)
  cmake_push_check_state(RESET)

  # Add to compiler
  set(CMAKE_REQUIRED_FLAGS "${_flag}")
  # Add to linker
  if(CMAKE_VERSION VERSION_LESS "3.14")
    set(CMAKE_REQUIRED_LIBRARIES "${_flag}")
  else()
    set(CMAKE_REQUIRED_LINK_OPTIONS "${_flag}")
  endif()

  # Normalize locale during test compilation.
  set(
    _locale_vars
    LC_ALL
    LC_MESSAGES
    LANG
  )
  foreach(v IN LISTS _locale_vars)
    set(_locale_vars_saved_${v} "$ENV{${v}}")
    set(ENV{${v}} C)
  endforeach()
  check_compiler_flag_common_patterns(_common_patterns)
  check_cxx_source_compiles(
    "int main() { return 0; }"
    ${_var}
    ${_common_patterns}
  )
  foreach(v IN LISTS _locale_vars)
    set(ENV{${v}} ${_locale_vars_saved_${v}})
  endforeach()
  set(${_var} "${${_var}}" PARENT_SCOPE)

  cmake_pop_check_state()
endfunction()

macro(_report_error sanitizer sanitizer_lib)
  message(
    STATUS
    "\
WARNING: ${sanitizer} Sanitizer was requested but is not working!\n\
--   => You may want to do the following:\n\
--   1- Check that your compiler(${CMAKE_CXX_COMPILER}) does support it,\n\
--   2- Make sure ${sanitizer_lib} is installed."
  )
endmacro()

# ---- Address Sanitizer
# ---------------------------------------------------------------------------

function(asap_add_google_asan target)
  # In order to use AddressSanitizer you will need to compile and link your
  # program using clang with the -fsanitize=address switch. To get a reasonable
  # performance add -O1 or higher. To get nicer stack traces in error messages
  # add -fno-omit-frame-pointer.
  set(
    SANITIZER_FLAGS_ASAN
    "-fsanitize=address"
    "-fno-omit-frame-pointer"
  )

  if(NOT DEFINED COMPILER_SUPPORTS_ASAN)
    # We'll use these flags to detect if the compiler supports ASan or not
    message(STATUS "Checking Address sanitizer...")
    _check_sanitizer_flags("${SANITIZER_FLAGS_ASAN}" COMPILER_SUPPORTS_ASAN)
    if(NOT COMPILER_SUPPORTS_ASAN)
      _report_error("Address" "libasan")
    endif()
  endif()

  if(COMPILER_SUPPORTS_ASAN)
    # Only create this internal target once
    if(NOT TARGET internal_asan)
      add_library(internal_asan INTERFACE IMPORTED)
      set_target_properties(
        internal_asan
        PROPERTIES
          INTERFACE_COMPILE_OPTIONS
            "${SANITIZER_FLAGS_ASAN}"
          INTERFACE_LINK_OPTIONS
            "${SANITIZER_FLAGS_ASAN}"
      )
    endif()
    target_link_libraries(${target} PRIVATE internal_asan)
  endif()
endfunction()

# ---- Undefined Behavior Sanitizer
# ----------------------------------------------------------------

function(asap_add_google_ubsan target)
  # To use UBSan, compile and link your program with -fsanitize=undefined. To
  # get nicer output for file names, we'll only keep the last 3 components of
  # the path.
  set(
    SANITIZER_FLAGS_UBSAN
    "-fsanitize=undefined"
    "-fsanitize-undefined-strip-path-components=-2"
  )

  if(NOT DEFINED COMPILER_SUPPORTS_UBSAN)
    # We'll use these flags to detect if the compiler supports ASan or not
    message(STATUS "Checking Undefined Behavior sanitizer...")
    _check_sanitizer_flags("${SANITIZER_FLAGS_UBSAN}" COMPILER_SUPPORTS_UBSAN)
    if(NOT COMPILER_SUPPORTS_UBSAN)
      _report_error("Undefined Behavior" "libubsan")
    endif()
  endif()

  if(COMPILER_SUPPORTS_UBSAN)
    # Only create this internal target once
    if(NOT TARGET internal_ubsan)
      add_library(internal_ubsan INTERFACE IMPORTED)
      set_target_properties(
        internal_ubsan
        PROPERTIES
          INTERFACE_COMPILE_OPTIONS
            "${SANITIZER_FLAGS_UBSAN}"
          INTERFACE_LINK_OPTIONS
            "${SANITIZER_FLAGS_UBSAN}"
      )
    endif()
    target_link_libraries(${target} PRIVATE internal_ubsan)
  endif()
endfunction()

# ---- Thread Sanitizer
# ----------------------------------------------------------------------------

function(asap_add_google_tsan target)
  # To use TSan, compile and link your program with -fsanitize=thread.
  set(SANITIZER_FLAGS_TSAN "-fsanitize=thread")

  if(NOT DEFINED COMPILER_SUPPORTS_TSAN)
    # We'll use these flags to detect if the compiler supports ASan or not
    message(STATUS "Checking Thread sanitizer...")
    _check_sanitizer_flags("${SANITIZER_FLAGS_TSAN}" COMPILER_SUPPORTS_TSAN)
    if(NOT COMPILER_SUPPORTS_TSAN)
      _report_error("Thread" "libtsan")
    endif()
  endif()

  if(COMPILER_SUPPORTS_TSAN)
    # Only create this internal target once
    if(NOT TARGET internal_tsan)
      add_library(internal_tsan INTERFACE IMPORTED)
      set_target_properties(
        internal_tsan
        PROPERTIES
          INTERFACE_COMPILE_OPTIONS
            "${SANITIZER_FLAGS_TSAN}"
          INTERFACE_LINK_OPTIONS
            "${SANITIZER_FLAGS_TSAN}"
      )
    endif()
    target_link_libraries(${target} PRIVATE internal_tsan)
  endif()
endfunction()

# ---- Helper to activate all sanitizers
# -----------------------------------------------------------

function(asap_add_sanitizers target)
  if(ASAP_WITH_GOOGLE_ASAN)
    asap_add_google_asan(${target})
  endif()
  if(ASAP_WITH_GOOGLE_UBSAN)
    asap_add_google_ubsan(${target})
  endif()
  if(ASAP_WITH_GOOGLE_TSAN)
    asap_add_google_tsan(${target})
  endif()

  # Add -O2 to get some reasonable performance during the test
  if(ASAP_WITH_GOOGLE_ASAN OR ASAP_WITH_GOOGLE_UBSAN OR ASAP_WITH_GOOGLE_TSAN)
    target_compile_options(${target} PRIVATE -O2)
  endif()
endfunction()
