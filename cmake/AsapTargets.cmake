# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

include(CMakePackageConfigHelpers)
include(common/CompileOptions)
include(common/SwiftTargets)
include(CompileDefinitions)
include(CompileOptions)

# ------------------------------------------------------------------------------
# Meta information about this module.
#
# Of particular importance is the MODULE_NAME, which can be composed of multiple
# segments separated by '.' or '_'. In such case, these segments will be used
# as path segments for the `api_export` generated file, and as identifier segments
# in the corresponding `_API` compiler defines.
#
# For example, `Super.Hero.Module` will produce a file that can be included as
# "super/hero/module/api_export.h" and will provide the export macro as
# `SUPER_HERO_MODULE_API`.
#
# It is a common practice and a recommended one to use a target name for that
# module with the same name (i.e. Super.Hero.Module).
# ------------------------------------------------------------------------------

macro(asap_declare_module)
  set(options)
  set(
    oneValueArgs
    MODULE_NAME
    DESCRIPTION
    GITHUB_REPO
    AUTHOR_MAINTAINER
    VERSION_MAJOR
    VERSION_MINOR
    VERSION_PATCH
  )
  set(multiValueArgs)

  cmake_parse_arguments(x "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT DEFINED x_MODULE_NAME)
    message(FATAL_ERROR "Module name is required.")
    return()
  endif()
  if(NOT (DEFINED x_VERSION_MAJOR AND DEFINED x_VERSION_MINOR AND DEFINED x_VERSION_PATCH))
    message(FATAL_ERROR "PLease specify all of VERSION_MAJOR VERSION_MINOR VERSION_PATCH for the module.")
    return()
  endif()

  # cmake-format: off
  set(META_MODULE_NAME "${x_MODULE_NAME}")
  set(META_MODULE_DESCRIPTION "${x_DESCRIPTION}")
  set(META_MODULE_GITHUB_REPO "${x_GITHUB_REPO}")
  set(META_MODULE_AUTHOR_MAINTAINER "${x_AUTHOR_MAINTAINER}")
  set(META_MODULE_VERSION_MAJOR "${x_VERSION_MAJOR}")
  set(META_MODULE_VERSION_MINOR "${x_VERSION_MINOR}")
  set(META_MODULE_VERSION_PATCH "${x_VERSION_PATCH}")
  set(META_MODULE_VERSION "${META_MODULE_VERSION_MAJOR}.${META_MODULE_VERSION_MINOR}.${META_MODULE_VERSION_PATCH}")
  set(META_MODULE_NAME_VERSION "${META_MODULE_PROJECT_NAME} v${META_MODULE_VERSION}")
  # cmake-format: on

  # Check if the module has been pushed on top of the hierarchy stack
  if(NOT ASAP_LOG_PROJECT_HIERARCHY MATCHES "(${META_MODULE_NAME})")
    message(
      AUTHOR_WARNING
      "Can't find module `${META_MODULE_NAME}` on the hierarchy stack. "
      "Please make sure it has been pushed with asap_push_module()."
    )
  endif()
endmacro()

# ------------------------------------------------------------------------------
# CMake/pkgconfig config files
# ------------------------------------------------------------------------------

function(_module_cmake_config_files)
  # generate the config file that includes the exports
  configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${MODULE_TARGET_NAME}Config.cmake"
    INSTALL_DESTINATION "${ASAP_INSTALL_CMAKE}/${META_MODULE_NAME}"
    PATH_VARS
      META_MODULE_VERSION
      MODULE_TARGET_NAME
  )

  # generate the version file for the config file
  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${MODULE_TARGET_NAME}ConfigVersion.cmake"
    VERSION "${META_MODULE_VERSION}"
    COMPATIBILITY AnyNewerVersion
  )
endfunction()

function(_module_pkgconfig_files)
  set(MODULE_PKGCONFIG_FILE ${MODULE_TARGET_NAME}.pc)
  get_target_property(type ${MODULE_TARGET_NAME} TYPE)
  if(NOT ${type} STREQUAL "INTERFACE_LIBRARY")
    get_target_property(TARGET_DEBUG_POSTFIX ${MODULE_TARGET_NAME} DEBUG_POSTFIX)
    set(MODULE_LINK_LIBS "-l${MODULE_TARGET_NAME}${TARGET_DEBUG_POSTFIX}")
  endif()
  configure_file(config.pc.in ${CMAKE_CURRENT_BINARY_DIR}/${MODULE_PKGCONFIG_FILE} @ONLY)
  if(${META_PROJECT_ID}_INSTALL)
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${MODULE_PKGCONFIG_FILE} DESTINATION ${ASAP_INSTALL_PKGCONFIG})
  endif()
endfunction()

function(asap_create_module_config_files)
  _module_cmake_config_files()
  _module_pkgconfig_files()
endfunction()

# ------------------------------------------------------------------------------
# Target creation helpers
# ------------------------------------------------------------------------------

macro(_add_common_compiler_options target warnings)
  # Set some common compiler options, and forward the 'WARNING' option if it was
  # provided
  if(warnings)
    asap_set_compile_options(${target} WARNING)
  else()
    asap_set_compile_options(${target})
  endif()
endmacro()

function(asap_add_library target)
  set(
    argOption
    EXCEPTIONS
    RTTI
    WARNING
  )
  set(argSingle CONTRACTS)
  set(argMulti)

  cmake_parse_arguments(x "${argOption}" "${argSingle}" "${argMulti}" ${ARGN})

  if(x_WARNING)
    set(warning_flag "WARNING")
  else()
    set(warning_flag)
  endif()

  # Contrarily to swift default, we enable exceptions and RTTI for all targets
  swift_add_library("${target}" EXCEPTIONS RTTI ${warning_flag}
                    ${x_UNPARSED_ARGUMENTS}
  )

  # We can refer to this target either with its standalone target name or with a
  # project scoped name (<project>::<module>) which we will alias to the target
  # name.
  add_library("${META_PROJECT_NAME}::${META_MODULE_NAME}" ALIAS ${target})
  get_target_property(type ${target} TYPE)
  if(NOT ${type} STREQUAL "INTERFACE_LIBRARY")
    # Set some common private compiler defines
    asap_set_compile_definitions(${target} CONTRACTS ${x_CONTRACTS})
    # Set common compiler options
    asap_set_compile_options(${target} ${warning_flag})
    # Generate export headers for the library
    asap_generate_export_headers(${target} ${META_MODULE_NAME})

    set_target_properties(
      ${target}
      PROPERTIES
        FOLDER
          "Libraries"
        VERSION
          ${META_MODULE_VERSION}
        SOVERSION
          ${META_MODULE_VERSION_MAJOR}
        DEBUG_POSTFIX
          "d"
        CXX_VISIBILITY_PRESET
          hidden
        VISIBILITY_INLINES_HIDDEN
          YES
    )
  endif()
endfunction()

function(asap_add_executable target)
  set(
    argOption
    EXCEPTIONS
    RTTI
    WARNING
  )
  set(argSingle CONTRACTS)
  set(argMulti)

  cmake_parse_arguments(x "${argOption}" "${argSingle}" "${argMulti}" ${ARGN})

  if(x_WARNING)
    set(warning_flag "WARNING")
  else()
    set(warning_flag)
  endif()

  # Contrarily to swift default, we enable exceptions and RTTI for all targets
  swift_add_executable("${target}" EXCEPTIONS RTTI ${warning_flag}
                       ${x_UNPARSED_ARGUMENTS}
  )
  # Set some common private compiler defines
  asap_set_compile_definitions(${target} CONTRACTS ${x_CONTRACTS})
  # Set common compiler options
  asap_set_compile_options(${target} ${warning_flag})
  set_target_properties(
    ${target}
    PROPERTIES
      FOLDER
        "Executables"
  )
endfunction()

function(asap_add_tool target)
  asap_add_executable(${target} ${ARGN})
  set_target_properties(
    ${target}
    PROPERTIES
      FOLDER
        "Tools"
  )
endfunction()

function(asap_add_tool_library target)
  asap_add_library(${target} ${ARGN})
  set_target_properties(
    ${target}
    PROPERTIES
      FOLDER
        "Tool Libraries"
  )
endfunction()
