# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Helpers to enhance progress reporting in the cmake output log.
#
# This module defines a global variable: `ASAP_LOG_PROJECT_HIERARCHY` that holds
# a string with the current project/module nesting hierarchy. It can be used in
# cmake `message` calls.
#
# Maintenance of the nesting hierarchy is done with the following macros:
#
# * asap_push_project(project_name)
# * asap_pop_project(project_name)
# * asap_push_module(module_name)
# * asap_pop_module(module_name)
#
# They must be called at the start(push) and end(pop) of a project/module cmake
# script to keep the hierarchy correct.
# ------------------------------------------------------------------------------

if(NOT DEFINED ASAP_LOG_PROJECT_HIERARCHY)
  set(ASAP_LOG_PROJECT_HIERARCHY_STACK "")
  set(ASAP_LOG_PROJECT_HIERARCHY "")
endif()

macro(asap_push_project project_name)
  list(APPEND ASAP_LOG_PROJECT_HIERARCHY_STACK "[${project_name}]")
  list(JOIN ASAP_LOG_PROJECT_HIERARCHY_STACK " > " ASAP_LOG_PROJECT_HIERARCHY)
  list(LENGTH ASAP_LOG_PROJECT_HIERARCHY_STACK depth)
  if(${META_PROJECT_ID}_IS_MASTER_PROJECT)
    message("=> [${depth}] in project ${ASAP_LOG_PROJECT_HIERARCHY} (master)")
  else()
    message("=> [${depth}] in project ${ASAP_LOG_PROJECT_HIERARCHY} (sub-project)")
  endif()
endmacro()

macro(asap_pop_project project_name)
  list(POP_BACK ASAP_LOG_PROJECT_HIERARCHY_STACK removed)
  if(NOT removed STREQUAL "[${project_name}]")
    message(FATAL_ERROR "Project [${removed}] was pushed but not popped, please fix this")
  endif()
  list(JOIN ASAP_LOG_PROJECT_HIERARCHY_STACK " > " ASAP_LOG_PROJECT_HIERARCHY)
  list(LENGTH ASAP_LOG_PROJECT_HIERARCHY_STACK depth)
  if(NOT ${depth} EQUAL 0)
    message(".. [${depth}] back to ${ASAP_LOG_PROJECT_HIERARCHY}")
  endif()
endmacro()

macro(asap_push_module module_name)
  list(APPEND ASAP_LOG_PROJECT_HIERARCHY_STACK "(${module_name})")
  list(JOIN ASAP_LOG_PROJECT_HIERARCHY_STACK " > " ASAP_LOG_PROJECT_HIERARCHY)
  list(LENGTH ASAP_LOG_PROJECT_HIERARCHY_STACK depth)
  message("=> [${depth}] in module ${ASAP_LOG_PROJECT_HIERARCHY}")
endmacro()

macro(asap_pop_module module_name)
  list(POP_BACK ASAP_LOG_PROJECT_HIERARCHY_STACK removed)
  if(NOT removed STREQUAL "(${module_name})")
    message(FATAL_ERROR "Module [${removed}] was pushed but not popped, please fix this")
  endif()
  list(JOIN ASAP_LOG_PROJECT_HIERARCHY_STACK " > " ASAP_LOG_PROJECT_HIERARCHY)
  list(LENGTH ASAP_LOG_PROJECT_HIERARCHY_STACK depth)
  message(".. [${depth}] back to ${ASAP_LOG_PROJECT_HIERARCHY}")
endmacro()
