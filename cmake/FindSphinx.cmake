# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# * This module looks for Sphinx Find the Sphinx documentation generator
#
# This modules defines SPHINX_EXECUTABLE SPHINX_FOUND

find_program(SPHINX_EXECUTABLE NAMES sphinx-build DOC "Sphinx documentation generator")

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
  Sphinx
  DEFAULT_MSG
  SPHINX_EXECUTABLE
)

mark_as_advanced(SPHINX_EXECUTABLE)
