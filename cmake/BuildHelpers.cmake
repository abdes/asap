# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

# ------------------------------------------------------------------------------
# Build Helpers to simplify target creation.
# ------------------------------------------------------------------------------

function(asap_generate_export_headers target include_dir)
  # Set API export file and macro
  string(MAKE_C_IDENTIFIER ${target} TEMPLATE_TARGET_ID)
  string(TOUPPER ${TEMPLATE_TARGET_ID} TEMPLATE_TARGET_ID)
  set(export_file "include/${include_dir}/${target}_export.h")
  set(template_export_file "include/${include_dir}/${target}_api.h")
  set(TEMPLATE_TARGET "${target}")
  set(TEMPLATE_INCLUDE_DIR "${include_dir}")

  # Create API export headers
  generate_export_header(${target} EXPORT_FILE_NAME ${export_file} EXPORT_MACRO_NAME ${TEMPLATE_TARGET_ID}_API)
endfunction()
