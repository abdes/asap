# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

include(common/ListTargets)

function(asap_get_all_targets result dir)
  get_all_targets(${result} ${dir} ${ARGM})
endfunction()

function(asap_list_targets out_var)
  swift_list_targets(${out_var}, ${ARGN})
endfunction()

function(asap_list_compilable_targets out_var)
  swift_list_compilable_targets(${out_var}, ${ARGN})
endfunction()
