# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# Execute cmake_install.cmake wrapper that allows to pass both DESTDIR and
# COMPONENT environment variable

execute_process(
  COMMAND
    ${CMAKE_COMMAND} -DCOMPONENT=$ENV{COMPONENT} -P cmake_install.cmake
)
