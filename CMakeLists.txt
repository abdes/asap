# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# CMake basic options
# ------------------------------------------------------------------------------

# It's time to move on! We require 3.14 for modern CMake with nice quality of
# life features and simpler scripts.
cmake_minimum_required(VERSION 3.14)

# List of directories specifying a search path for CMake modules to be loaded by
# the the include() or find_package() commands before checking the default
# modules that come with CMake.
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
# But if this project is not the master project, prioritize the master project
# cmake include dir if it exists.
if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR AND EXISTS "${CMAKE_SOURCE_DIR}/cmake")
  list(PREPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
endif()
# Include the log helpers module early so we can use early for logging the
# project hierarchy
include(LogHelpers)

# Setup our override file, in which we may cleanup cmake's default compiler
# options, based on what we are doing.
set(CMAKE_USER_MAKE_RULES_OVERRIDE "ResetInitialCompilerOptions")

# ------------------------------------------------------------------------------
# Project description and (meta) information
# ------------------------------------------------------------------------------

# Get git revision
include(GetGitRevisionDescription)
get_git_head_revision(GIT_REFSPEC GIT_SHA1)
string(SUBSTRING "${GIT_SHA1}" 0 12 GIT_REV)
if(NOT GIT_SHA1)
  set(GIT_REV "0")
endif()

# Meta information about the project
# gersemi: off
set(META_PROJECT_NAME        "asap")
set(META_PROJECT_DESCRIPTION "Instantly start with a fully loaded CMake project")
set(META_AUTHOR_ORGANIZATION "The Authors")
set(META_GITHUB_REPO         "https://github.com/abdes/asap")
set(META_AUTHOR_DOMAIN       "https://github.com/abdes/asap")
set(META_AUTHOR_MAINTAINER   "Abdessattar Sassi")
set(META_VERSION_MAJOR       "4") # x-release-please-major
set(META_VERSION_MINOR       "7") # x-release-please-minor
set(META_VERSION_PATCH       "0") # x-release-please-patch
set(META_VERSION_REVISION    "${GIT_REV}")
set(META_VERSION             "${META_VERSION_MAJOR}.${META_VERSION_MINOR}.${META_VERSION_PATCH}")
set(META_NAME_VERSION        "${META_PROJECT_NAME} v${META_VERSION} (${META_VERSION_REVISION})")
# gersemi: on

string(MAKE_C_IDENTIFIER ${META_PROJECT_NAME} META_PROJECT_ID)
string(TOUPPER ${META_PROJECT_ID} META_PROJECT_ID)
string(TOLOWER ${META_PROJECT_ID} META_PROJECT_ID_LOWER)

# Determine if this is built as a subproject  or if it is the master project.
if(NOT DEFINED ${META_PROJECT_ID}_IS_MASTER_PROJECT)
  set(${META_PROJECT_ID}_IS_MASTER_PROJECT OFF)
  if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(${META_PROJECT_ID}_IS_MASTER_PROJECT ON)
  endif()
endif()

# Push the project on the hierarchy stack after we have determined if it is a
# master or a sub-project.
asap_push_project(${META_PROJECT_NAME})

# ------------------------------------------------------------------------------
# Project configuration options
# ------------------------------------------------------------------------------

# Project options
# gersemi: off
set(OPTIONS_LIST
  BUILD_SHARED_LIBS        "Build shared instead of static libraries." ON
  ASAP_BUILD_TESTS         "Setup target to build and run tests." OFF
  ASAP_BUILD_EXAMPLES      "Setup target to build the examples." OFF
  ASAP_BUILD_DOCS          "Setup target to build the documentation." OFF
  ASAP_WITH_GOOGLE_ASAN    "Instrument code with address sanitizer" OFF
  ASAP_WITH_GOOGLE_UBSAN   "Instrument code with undefined behavior sanitizer" OFF
  ASAP_WITH_GOOGLE_TSAN    "Instrument code with thread sanitizer" OFF
  ASAP_WITH_VALGRIND       "Instrument code with valgrind profilers" OFF
  ASAP_WITH_DOXYGEN        "Create targets for doxygen api docs" OFF
  ASAP_WITH_SPHINX         "Create targets for sphinx docs" OFF
  ASAP_WITH_CLANG_FORMAT   "Create targets for clang-format" ON
  ASAP_WITH_CLANG_TIDY     "Create targets for clang-tidy" ON
  USE_CCACHE               "Enable caching of compiled artifacts using ccache" OFF
)
# gersemi: on
# Process each option

message(STATUS "PROJECT OPTIONS:")
list(LENGTH OPTIONS_LIST OPTIONS_LIST_length)
math(EXPR OPTIONS_LIST_length "${OPTIONS_LIST_length}-1")
foreach(index RANGE 0 ${OPTIONS_LIST_length} 3)
  list(GET OPTIONS_LIST ${index} OPTION_NAME)
  math(EXPR index "${index}+1")
  list(GET OPTIONS_LIST ${index} OPTION_DESCRIPTION)
  math(EXPR index "${index}+1")
  list(GET OPTIONS_LIST ${index} OPTION_DEFAULT)

  if(DEFINED ${OPTION_NAME})
    if(NOT "${${OPTION_NAME}}" STREQUAL "$CACHE{${OPTION_NAME}}")
      message(STATUS ". ${OPTION_NAME}: ${${OPTION_NAME}} - provided (cache: $CACHE{${OPTION_NAME}})")
    else()
      message(STATUS ". ${OPTION_NAME}: ${${OPTION_NAME}} - cache")
    endif()
  else()
    set(${OPTION_NAME} ${OPTION_DEFAULT} CACHE BOOL ${OPTION_DESCRIPTION} FORCE)
    message(STATUS ". ${OPTION_NAME}: ${${OPTION_NAME}} - force set")
  endif()
endforeach()

# ------------------------------------------------------------------------------
# Project Declaration
# ------------------------------------------------------------------------------

# Generate folders for IDE targets (e.g., VisualStudio solutions)
set_property(
  GLOBAL
  PROPERTY
    USE_FOLDERS
      ON
)
set(IDE_FOLDER "${META_PROJECT_NAME}")

# Declare project
project(
  ${META_PROJECT_NAME}
  VERSION ${META_VERSION}
  DESCRIPTION ${META_PROJECT_DESCRIPTION}
  HOMEPAGE_URL ${META_GITHUB_REPO}
  LANGUAGES
    C
    CXX
)

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Define the following alias variables used by the common cmake functions
set(${PROJECT_NAME}_BUILD_TESTS ${ASAP_BUILD_TESTS})
set(${PROJECT_NAME}_BUILD_EXAMPLES ${ASAP_BUILD_EXAMPLES})

# ---- Add dependencies via CPM ----
# see https://github.com/TheLartians/CPM.cmake for more info

include(cmake/CPM.cmake)
# We make sure that we have 'third_party' in the name so that the targets get
# excluded from the generated target lists for the various tools.
set(FETCHCONTENT_BASE_DIR ${CMAKE_BINARY_DIR}/third_party_deps)

# ---- Speedup build using ccache (needs CPM) ----
include(cmake/FasterBuild.cmake)

# ------------------------------------------------------------------------------
# Top level code generation
# ------------------------------------------------------------------------------

# Generate version-header
configure_file(templates/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/include/${META_PROJECT_ID_LOWER}/version.h)

# Generate a clangd configuration file that points to the compilation database
# in the cmake build directory. We need to do this as the build directory is
# different for every preset and can be different as well when the user decides
# to build somewhere else. Currently we cannot configure this properly in vscode
# settings. See https://github.com/clangd/vscode-clangd/issues/48
if(NOT EXISTS ${CMAKE_SOURCE_DIR}/.clangd)
  configure_file(.clangd.in ${CMAKE_SOURCE_DIR}/.clangd @ONLY)
endif()

# ------------------------------------------------------------------------------
# Documentation - doxygen, sphinx/breathe/exhale
# ------------------------------------------------------------------------------

if(ASAP_BUILD_DOCS)
  if(ASAP_WITH_DOXYGEN)
    # Doxygen
    set(DOXYGEN_BUILD_DIR "${CMAKE_BINARY_DIR}/dox")
    include(DoxGeneration)
  endif()

  if(ASAP_WITH_SPHINX)
    # Sphinx/breathe/exhale
    set(SPHINX_BUILD_DIR "${CMAKE_BINARY_DIR}/sphinx")
    include(SphinxGeneration)
  endif()
endif()

# ------------------------------------------------------------------------------
# Testing
# ------------------------------------------------------------------------------

include(CTest)

if(ASAP_BUILD_TESTS)
  include(GoogleSanitizers)
  include(CodeCoverage)
  # Enable this target when the project has test cases
  asap_add_code_coverage_all_targets()
  if(ASAP_WITH_VALGRIND)
    include(Valgrind)
  endif()

  cpmaddpackage(
    NAME
    googletest
    GIT_TAG
    main
    GITHUB_REPOSITORY
    google/googletest
    OPTIONS
    "gtest_force_shared_crt ON"
    "INSTALL_GTEST OFF"
  )

  include(GoogleTest)
endif()

# ------------------------------------------------------------------------------
# Third party modules
#
# Call after documentation but before project modules and before adding common
# cmake modules.
# ------------------------------------------------------------------------------

add_subdirectory(third_party)

# ------------------------------------------------------------------------------
# Additional CMake modules
# ------------------------------------------------------------------------------

# Register general cmake commands
include(AsapTargets)
include(BuildHelpers)
include(GenerateExportHeader)

# Override the ${META_PROJECT_ID}_INSTALL option to ON/OFF to respectively force
# install/no-install behavior for this project. This is particularly useful when
# this project is used as a sub-project and the user publicly depends on it and
# wants to have a self-contained install.
include(AsapInstall)

# The default build type provided by CMake is to include no compiler flags for
# optimization. For some projects you may want to set a default build type so
# that you do not have to remember to set it.
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'RelWithDebInfo' as none was specified.")
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(
    CACHE
      CMAKE_BUILD_TYPE
    PROPERTY
      STRINGS
        "Debug"
        "Release"
        "MinSizeRel"
        "RelWithDebInfo"
  )
endif()

# ------------------------------------------------------------------------------
# RPATH setup
# ------------------------------------------------------------------------------

if(APPLE)
  set(CMAKE_MACOSX_RPATH ON)
endif()

# Set runtime path
set(CMAKE_SKIP_BUILD_RPATH FALSE) # Add absolute path to all dependencies for
# BUILD
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)

if(NOT SYSTEM_DIR_INSTALL)
  set(CMAKE_INSTALL_RPATH "$ORIGIN/${ASAP_INSTALL_LIB}")
endif()

# ------------------------------------------------------------------------------
# Project modules
# ------------------------------------------------------------------------------

add_subdirectory(tools/version-info)

# Add project modules here

# ------------------------------------------------------------------------------
# Code analyzers: clang-tidy, cppcheck, valgrind, sanitizers, etc...
#
# Call after sub-modules have been added so that source code files can be
# properly collected for analysis.
# ------------------------------------------------------------------------------

if(${META_PROJECT_ID}_IS_MASTER_PROJECT)
  if(ASAP_WITH_CLANG_TIDY)
    include(ClangTidy)
    asap_create_clang_tidy_targets()
  endif()

  if(ASAP_WITH_CLANG_FORMAT)
    include(ClangFormat)
    asap_create_clang_format_targets()
  endif()
endif()

asap_pop_project(${META_PROJECT_NAME})
