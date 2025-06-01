# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

function(asap_create_clang_tidy_targets)
  include(common/ClangTidy)
  swift_create_clang_tidy_targets(DONT_GENERATE_CLANG_TIDY_CONFIG ${ARGV})
endfunction()
