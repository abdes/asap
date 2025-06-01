# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Build Helpers to simplify target creation.
# ------------------------------------------------------------------------------

function(identifier_to_upper_snake_case identifier)
  set(result)

  # Extract words from the identifier expecting it to be using '_' or '.' to
  # compose a hierarchy of segments
  string(REGEX MATCHALL "[A-Za-z][^_.]*" words ${identifier})

  # Process each word
  foreach(word IN LISTS words)
    if("${word}" STREQUAL "_" OR "${word}" STREQUAL ".")
      string(APPEND result "_")
    else()
      string(TOUPPER "${word}" word_upper)
      list(APPEND result "${word_upper}")
    endif()
  endforeach()

  # Join words with underscores
  string(JOIN "_" upper_snake_case_identifier ${result})

  # Set the upper snake case identifier in the parent scope
  set(base_name "${upper_snake_case_identifier}" PARENT_SCOPE)

  # Join words with slashes and convert to lowercase
  if(NOT result)
    set(lower_case_path "")
  else()
    string(JOIN "/" lower_case_path ${result})
    string(TOLOWER ${lower_case_path} lower_case_path)
  endif()

  # Set the template include directory in the parent scope
  set(template_include_dir "${lower_case_path}" PARENT_SCOPE)
endfunction()

function(asap_generate_export_headers target)
  # Set API export file and macro
  identifier_to_upper_snake_case(${target})
  set(export_file "include/${template_include_dir}/api_export.h")
  # Create API export headers
  generate_export_header(${target} BASE_NAME ${base_name} EXPORT_FILE_NAME ${export_file} EXPORT_MACRO_NAME ${base_name}_API)
endfunction()
