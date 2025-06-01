# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

function(asap_create_clang_format_targets)
  include(common/ClangFormat)
  swift_setup_clang_format(
    CLANG_FORMAT_NAMES
      clang-format
      clang-format-19
      clang-format-18
      clang-format-17
      clang-format-16
      clang-format-15
      clang-format-14
    ${ARGV}
  )
endfunction()
