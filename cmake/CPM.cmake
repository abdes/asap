# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# Do this only once for the project by checking if we already have loaded CPM
# which will define the CURRENT_CPM_VERSION, and if that version is what we want
# to have here.
if(NOT CURRENT_CPM_VERSION VERSION_EQUAL 0.40.2)
  set(CPM_DOWNLOAD_VERSION 0.40.2)

  if(CPM_SOURCE_CACHE)
    # Expand relative path. This is important if the provided path contains a
    # tilde (~)
    get_filename_component(CPM_SOURCE_CACHE ${CPM_SOURCE_CACHE} ABSOLUTE)
    set(CPM_DOWNLOAD_LOCATION "${CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
  elseif(DEFINED ENV{CPM_SOURCE_CACHE})
    set(CPM_DOWNLOAD_LOCATION "$ENV{CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
  else()
    set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
  endif()

  if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
    message(STATUS "Downloading CPM.cmake to ${CPM_DOWNLOAD_LOCATION}")
    file(
      DOWNLOAD
        https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake
        ${CPM_DOWNLOAD_LOCATION}
    )
  endif()
  include(${CPM_DOWNLOAD_LOCATION})
endif()

# This is a wrapper function around CPM `cpmaddpackage` to automatically
# push/pop the package on the hierarchy stack for logging. Use it instead of
# calling CPM.
function(asap_add_package)
  set(options)
  set(oneValueArgs NAME)
  set(multiValueArgs)

  cmake_parse_arguments(x "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT DEFINED x_NAME)
    message(FATAL_ERROR "Package name is required. Refer to CPM docs for the full usage.")
    return()
  endif()
  asap_push_module(${x_NAME})
  cpmaddpackage(NAME ${x_NAME} ${ARGN})
  asap_pop_module(${x_NAME})
endfunction()
