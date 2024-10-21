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
  string(MAKE_C_IDENTIFIER "${identifier}" c_identifier)
  string(REGEX MATCHALL "^[A-Z][A-Z0-9]*[a-z0-9]*" words ${c_identifier})
  foreach(word IN LISTS words)
    if(word STREQUAL "_")
      string(APPEND result "_")
    else()
      string(TOUPPER "${word}" word_upper)
      list(APPEND result "${word_upper}")
    endif()
  endforeach()
  string(JOIN "_" out ${result})
  set(base_name "${out}" PARENT_SCOPE)
  string(JOIN "/" out ${result})
  string(TOLOWER ${out} out)
  set(template_include_dir "${META_PROJECT_ID_LOWER}/${out}" PARENT_SCOPE)
endfunction()

function(asap_generate_export_headers target)
  # Set API export file and macro
  identifier_to_upper_snake_case(${target})
  set(export_file "include/${template_include_dir}/api_export.h")
  # Create API export headers
  generate_export_header(${target} BASE_NAME ${base_name} EXPORT_FILE_NAME ${export_file} EXPORT_MACRO_NAME ${base_name}_API)
endfunction()
