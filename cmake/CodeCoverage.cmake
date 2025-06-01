# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

#
# Code coverage only works with clang/gcc.
#
if("${CMAKE_C_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang|GNU")
  include(common/CodeCoverage)

  function(asap_add_code_coverage)
    add_code_coverage(${ARGV})
  endfunction()

  function(asap_add_code_coverage_all_targets)
    # Add standard exclusion patterns for code coverage reports
    if("${CMAKE_C_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang")
      # For clang we'll be using llvm-cov which expect regex as input for
      # exclusions
      set(
        STANDARD_EXCLUDES
        '.*/test/.*'
        '.*/\.cache/CPM/.*'
        '/usr/.*'
      )
    else()
      # For GNU however, we'll be using lcov which expects file patterns as
      # input for excludions
      set(
        STANDARD_EXCLUDES
        */test/*
        */.cache/CPM/*
        /usr/*
      )
    endif()
    add_code_coverage_all_targets(EXCLUDE ${STANDARD_EXCLUDES} ${ARGV})
  endfunction()
else()
  function(target_code_coverage)
    # empty
  endfunction()

  function(asap_add_code_coverage)
    # empty
  endfunction()

  function(asap_add_code_coverage_all_targets)
    # empty
  endfunction()
endif()
