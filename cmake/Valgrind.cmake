# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

mark_as_advanced(${PROJECT_NAME}_ENABLE_PROFILING)
set(${PROJECT_NAME}_ENABLE_PROFILING ${ASAP_WITH_VALGRIND})

include(common/Valgrind)
