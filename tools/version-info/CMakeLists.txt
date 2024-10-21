# ===------------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause).
# SPDX-License-Identifier: BSD-3-Clause
# ===------------------------------------------------------------------------===#

set(my_name "version-info")
asap_push_module("${my_name}")

# ------------------------------------------------------------------------------
# Meta information about the this module
# ------------------------------------------------------------------------------

asap_declare_module(
  MODULE_NAME
  "${my_name}"
  DESCRIPTION
  "Print the project's version information."
  GITHUB_REPO
  "${META_GITHUB_REPO}"
  AUTHOR_MAINTAINER
  "${META_AUTHOR_MAINTAINER}"
  VERSION_MAJOR
  "1"
  VERSION_MINOR
  "0"
  VERSION_PATCH
  "0"
)

# ==============================================================================
# Build instructions
# ==============================================================================

# ------------------------------------------------------------------------------
# Code generation
# ------------------------------------------------------------------------------

# Generate version-header
configure_file(src/main.cpp.in ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp)

# ------------------------------------------------------------------------------
# Main module target
# ------------------------------------------------------------------------------

set(MODULE_TARGET_NAME "${META_PROJECT_NAME}-${META_MODULE_NAME}")

asap_add_executable(${MODULE_TARGET_NAME} WARNING SOURCES "src/main.cpp")

target_compile_features(${MODULE_TARGET_NAME} PUBLIC cxx_constexpr)

cmake_path(SET version_include_dir ${CMAKE_CURRENT_BINARY_DIR}/../../include NORMALIZE)
target_include_directories(
  ${MODULE_TARGET_NAME}
  PUBLIC $<INSTALL_INTERFACE:include> $<BUILD_INTERFACE:${version_include_dir}>
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

# ------------------------------------------------------------------------------
# Run executable test
# ------------------------------------------------------------------------------

# Always run the version-info as part of ctest suite
add_test(NAME "Misc:version-info" COMMAND ${MODULE_TARGET_NAME} WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

# ==============================================================================
# Deployment instructions
# ==============================================================================

if(${META_PROJECT_ID}_INSTALL)
  set(TARGETS_EXPORT_NAME "${MODULE_TARGET_NAME}Targets")
  set(runtime "${MODULE_TARGET_NAME}_runtime")
  set(dev "${MODULE_TARGET_NAME}_dev")

  # Binaries
  install(
    TARGETS ${MODULE_TARGET_NAME}
    EXPORT "${TARGETS_EXPORT_NAME}"
    COMPONENT
    runtime
    RUNTIME DESTINATION ${ASAP_INSTALL_BIN} COMPONENT ${runtime}
    LIBRARY DESTINATION ${ASAP_INSTALL_SHARED} COMPONENT ${runtime}
    ARCHIVE DESTINATION ${ASAP_INSTALL_LIB} COMPONENT ${dev}
  )

  # Docs
  if(EXISTS ${SPHINX_BUILD_DIR}/${MODULE_TARGET_NAME})
    install(
      DIRECTORY ${SPHINX_BUILD_DIR}/${MODULE_TARGET_NAME}
      DESTINATION ${ASAP_INSTALL_DOC}
      COMPONENT ${MODULE_TARGET_NAME}_docs
    )
  endif()
endif()

asap_pop_module("${my_name}")
