# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Reduce build time by using ccache when available
# ------------------------------------------------------------------------------

# Only do the following if we have not already done it in this project or in in
# its parent hierarchy of projects.
if(NOT DEFINED CMAKE_CXX_COMPILER_LAUNCHER OR NOT DEFINED CMAKE_C_COMPILER_LAUNCHER)
  find_program(CCACHE_TOOL_PATH ccache)

  if(NOT WIN32 AND USE_CCACHE AND CCACHE_TOOL_PATH)
    message(STATUS "Using ccache (${CCACHE_TOOL_PATH}) (via wrapper).")
    # see https://github.com/TheLartians/Ccache.cmake enables CCACHE support
    # through the USE_CCACHE flag possible values are: YES, NO or equivalent
    cpmaddpackage("gh:TheLartians/Ccache.cmake@1.2.3")
  elseif(WIN32 AND USE_CCACHE AND CCACHE_TOOL_PATH)
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_TOOL_PATH} CACHE STRING "" FORCE)
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_TOOL_PATH} CACHE STRING "" FORCE)
    message(STATUS "Using ccache (${CCACHE_TOOL_PATH}).")
  endif()
endif()
