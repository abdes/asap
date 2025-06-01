# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Documentation with Sphinx/Breathe/Exhale
# ------------------------------------------------------------------------------

# To avoid indiscriminately generating documentation for all modules in the
# project, including third party modules and stuff for which we don't want
# documentation to be generated, we provide here the basic tools to add
# breathe/exhale capabilities to a module. Additionally, exhale can only process
# one module at a time, so we need to have the generation run for each module.
#
# Doxygen is run separately NOT by exhale. Sphinx targets must be run after
# doxygen.
#
# To use in a submodule or in the master module add the following:
#
# ~~~
#      asap_with_sphinx(${target})
# ~~~
#
# Use 'make sphinx' to generate documentation. (not done by default)
#

include(FindSphinx)

if(SPHINX_FOUND)
  macro(_master_sphinx_target)
    string(MAKE_C_IDENTIFIER ${META_PROJECT_NAME} project_id)
    string(TOLOWER ${project_id} project_id)
    set(master_sphinx_target ${project_id})
  endmacro()

  # The macro to add a submodule as a sphinx target.
  function(asap_with_sphinx TARGET_NAME)
    # Nothing will be done unless the module is being built as a master project.
    if(NOT ${META_PROJECT_ID}_IS_MASTER_PROJECT)
      return()
    endif()

    # Setup work directory for the target module
    set(SPHINX_TARGET_WORKDIR "${SPHINX_BUILD_DIR}/${TARGET_NAME}")
    if(NOT EXISTS "${SPHINX_TARGET_WORKDIR}")
      file(MAKE_DIRECTORY "${SPHINX_TARGET_WORKDIR}")
    endif()
    # Do @ substitutions in the sphinx config file for the module
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/doc/conf.py.in" "${CMAKE_CURRENT_SOURCE_DIR}/doc/conf.py" @ONLY)

    # Add a target for building the sphinx documentation of the module
    message(STATUS "[sphinx] Adding module sphinx target: ${TARGET_NAME}_sphinx")
    add_custom_target(
      ${TARGET_NAME}_sphinx
      COMMAND
        ${SPHINX_EXECUTABLE} -q -b html -c "${EXHALE_TARGET_WORKDIR}" -d "${SPHINX_TARGET_WORKDIR}/_doctrees"
        "${CMAKE_CURRENT_SOURCE_DIR}/doc" "${SPHINX_TARGET_WORKDIR}/html"
      WORKING_DIRECTORY "${SPHINX_TARGET_WORKDIR}"
      VERBATIM
      COMMENT "Generating `sphinx` documentation for `${TARGET_NAME}`"
    )
    set_target_properties(
      ${TARGET_NAME}_sphinx
      PROPERTIES
        EXCLUDE_FROM_ALL
          TRUE
    )
    # Finally add the module sphinx target as a dependency for the overall
    # sphinx target
    if(${META_PROJECT_ID}_IS_MASTER_PROJECT)
      _master_sphinx_target()
      add_dependencies(${master_sphinx_target}_sphinx ${TARGET_NAME}_sphinx)
    endif()
  endfunction()

  if(NOT TARGET sphinx)
    # Add a top-level sphinx target to collect all submodules, but only if this
    # is the top-level project and not a sub-project
    message(STATUS "[sphinx] Adding top-level sphinx target: sphinx")
    add_custom_target(sphinx)
    # We only build documentation through explicit invocation of the sphinx
    # target as it is pretty heavy and requires doxygen to be run before it is
    # invoked.
    set_target_properties(
      sphinx
      PROPERTIES
        EXCLUDE_FROM_ALL
          TRUE
    )

    # Setup sphinx doc master target and add other submodules as dependencies
    function(_add_master_sphinx_target)
      _master_sphinx_target()
      asap_with_sphinx(${master_sphinx_target})

      set(index_file_src "${CMAKE_CURRENT_SOURCE_DIR}/doc/index.html")
      set(index_file_out "${CMAKE_CURRENT_BINARY_DIR}/sphinx/index.html")
      if(EXISTS ${index_file_src})
        message(STATUS "Will use project custom doc index file: ${index_file_src}")
        # Add a target for copying the index.html from the doc dir to the sphinx
        # build dir. A dependency on this target will be added to the master
        # sphinx target.
        add_custom_command(
          OUTPUT
            ${index_file_out}
          COMMAND
            ${CMAKE_COMMAND} -E copy ${index_file_src} ${index_file_out}
          DEPENDS
            ${index_file_src}
        )
        add_custom_target(copy_doc_index ALL DEPENDS ${index_file_out})
        add_dependencies(${master_sphinx_target}_sphinx copy_doc_index)
      endif()
      add_dependencies(sphinx ${master_sphinx_target}_sphinx)
    endfunction()
    _add_master_sphinx_target()
  endif()
else(SPHINX_FOUND)
  message(STATUS "Restructured text documentation generation targets will not be added.")

  function(asap_with_sphinx TARGET_NAME)
  endfunction()
endif(SPHINX_FOUND)
