# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# API Documentation
# ------------------------------------------------------------------------------

# To avoid indiscriminately generating documentation for all modules in the
# project, including third party modules and stuff for which we don't want
# documentation to be generated, we provide here the basic tools to add doxygen
# capabilities to a module.
#
# To use in a specific CmakeLists.txt add the following:
#
# ~~~
#      asap_with_doxygen(
#        ${target}
#        "\"<Title>\""
#        "\"<Desscription>\""
#        "<List of directories to include>")
# ~~~
#
# Use 'make dox' to generate documentation. (not done by default)
#

include(FindDoxygen)

if(DOXYGEN_FOUND)
  function(
    _configure_doxyfile
    MODULE_NAME
    VERSION
    TITLE
    BRIEF
    INPUT_PATH
  )
    if(EXISTS "${CMAKE_SOURCE_DIR}/doxygen/Doxyfile.in")
      set(DOXY_OUTPUT_DIR "${MODULE_NAME}")
      set(DOXY_MODULE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
      set(DOXY_MODULE_NAME "${MODULE_NAME}")
      set(DOXY_MODULE_VERSION "${VERSION}")
      set(DOXY_TITLE "${TITLE}")
      set(DOXY_BRIEF "${BRIEF}")
      set(DOXY_INPUT_PATH "${INPUT_PATH}")

      set(DOXY_EXAMPLE_PATH)
      if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test")
        list(APPEND DOXY_EXAMPLE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/test")
      endif()
      if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/examples")
        list(APPEND DOXY_EXAMPLE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/examples")
      endif()
      string(REPLACE ";" ", " DOXY_EXAMPLE_PATH "${DOXY_EXAMPLE_PATH}")

      if(NOT EXISTS "${DOXYGEN_BUILD_DIR}/${DOXY_OUTPUT_DIR}")
        file(MAKE_DIRECTORY "${DOXYGEN_BUILD_DIR}/${DOXY_OUTPUT_DIR}")
      endif()
      configure_file("${CMAKE_SOURCE_DIR}/doxygen/Doxyfile.in" "${DOXYGEN_BUILD_DIR}/${MODULE_NAME}_Doxyfile" @ONLY)
    else()
      message(STATUS "WARNING: The '${CMAKE_SOURCE_DIR}/doxygen/Doxyfile.in' file does not exist!")
    endif()
  endfunction()

  function(_add_doxygen_target MODULE_NAME)
    message(STATUS "[doxygen] Adding module doxygen target: ${MODULE_NAME}_dox")
    add_custom_target(
      ${MODULE_NAME}_dox
      COMMAND
        ${CMAKE_COMMAND} -E remove -f "${MODULE_NAME}_Doxyfile.out"
      COMMAND
        ${CMAKE_COMMAND} -E copy "${MODULE_NAME}_Doxyfile" "${MODULE_NAME}_Doxyfile.out"
      COMMAND
        ${DOXYGEN_EXECUTABLE} "${MODULE_NAME}_Doxyfile.out"
      COMMAND
        ${CMAKE_COMMAND} -E remove -f "${MODULE_NAME}_Doxyfile.out"
      WORKING_DIRECTORY "${DOXYGEN_BUILD_DIR}"
      COMMENT "Generating doxygen documentation for \"${MODULE_NAME}\""
      VERBATIM
    )
    set_target_properties(
      ${MODULE_NAME}_dox
      PROPERTIES
        EXCLUDE_FROM_ALL
          TRUE
    )
    add_dependencies(dox ${MODULE_NAME}_dox)
  endfunction()

  function(asap_with_doxygen)
    # Nothing will be done unless the module is being built as a master project.
    if(NOT ${META_PROJECT_ID}_IS_MASTER_PROJECT)
      return()
    endif()

    set(options)
    set(
      oneValueArgs
      MODULE_NAME
      VERSION
      TITLE
      BRIEF
      INPUT_PATH
    )
    set(multiValueArgs)

    cmake_parse_arguments(x "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT DEFINED x_MODULE_NAME)
      message(FATAL_ERROR "Module name is required.")
      return()
    endif()
    if(NOT DEFINED x_VERSION)
      message(FATAL_ERROR "Version string (M.m.p) is required.")
      return()
    endif()
    if(NOT DEFINED x_TITLE)
      set(x_TITLE "Module `${x_MODULE_NAME}`")
    endif()
    if(NOT DEFINED x_BRIEF)
      set(x_BRIEF "Documentation for module `${x_MODULE_NAME}`")
    endif()
    if(NOT DEFINED x_INPUT_PATH)
      message(FATAL_ERROR "Input path (list of directories) is required.")
      return()
    endif()

    # Substitute variables in the doxygen config file for the target
    _configure_doxyfile(${x_MODULE_NAME} ${x_VERSION} ${x_TITLE} ${x_BRIEF}
                        ${x_INPUT_PATH}
    )
    # Add the target as a dependency to the master dox target
    _add_doxygen_target(${x_MODULE_NAME})
  endfunction()

  if(NOT TARGET dox)
    # The master doxygen target
    message(STATUS "[doxygen] Adding master doxygen target: dox")
    add_custom_target(dox)
    # We don't want it to be rebuilt everytime we build all. Need to explicitly
    # request it to be built.
    set_target_properties(
      dox
      PROPERTIES
        EXCLUDE_FROM_ALL
          TRUE
    )

    # We'll make a special script to collect all doxygen warnings from
    # submodules and print them at the end of the doxygen run. This mwill make
    # it easier to detect if there were doxygen warnings in the project and
    # eventually fail the build in a CI environment for example.

    set(COLLECT_WARNINGS_SCRIPT "${DOXYGEN_BUILD_DIR}/collect_warnings.cmake")
    # cmake-format: off
    file(
      WRITE
      "${COLLECT_WARNINGS_SCRIPT}"
      " \
    # Collect warnings from submodules into the consolidated warnings file\n \
    file(WRITE \"${DOXYGEN_BUILD_DIR}/${MODULE_NAME}/doxygen_warnings.txt\" \"\")\n \
    file(GLOB_RECURSE DOX_MODULES \"module_warnings.txt\")\n \
    foreach(MODULE \${DOX_MODULES})\n \
      message(\"  collecting doxygen warnings from \${MODULE}\")\n \
      file(READ \"\${MODULE}\" MODULE_WARNINGS)\n \
      file(APPEND \"${DOXYGEN_BUILD_DIR}/doxygen_warnings.txt\" \"\${MODULE_WARNINGS}\")\n \
    endforeach(MODULE)\n \
    file(READ \"${DOXYGEN_BUILD_DIR}/doxygen_warnings.txt\" ALL_WARNINGS)\n \
    string(COMPARE NOTEQUAL \"\${ALL_WARNINGS}\" \"\" DOXYGEN_HAD_WARNINGS)\n \
    if(DOXYGEN_HAD_WARNINGS)\n \
      # Print the warnings\n \
      message(\"\${ALL_WARNINGS}\")\n \
    endif(DOXYGEN_HAD_WARNINGS)\n"
    )
    # cmake-format: on

    # Custom command to collect warnings and print them
    add_custom_command(
      TARGET dox
      POST_BUILD
      COMMAND
        ${CMAKE_COMMAND} -P "${COLLECT_WARNINGS_SCRIPT}"
      WORKING_DIRECTORY "${DOXYGEN_BUILD_DIR}"
      COMMENT "Running post-build command for dox"
    )
  endif()
else()
  message(
    WARNING
    "`doxygen` is not available on this system! "
    "API documentation generation targets will not be added."
  )

  function(asap_with_doxygen)
  endfunction()
endif()
