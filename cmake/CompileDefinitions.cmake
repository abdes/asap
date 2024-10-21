# ===-----------------------------------------------------------------------===#
# Distributed under the 3-Clause BSD License. See accompanying file LICENSE or
# copy at https://opensource.org/licenses/BSD-3-Clause.
# SPDX-License-Identifier: BSD-3-Clause
# ===-----------------------------------------------------------------------===#

include_guard(GLOBAL)

# ------------------------------------------------------------------------------
# Set a common set of compile definitions.
#
# Compile definitions can be removed from the default set by passing REMOVE
# followed by a list of symbols, eg:
#
# asap_set_compile_definitions(sample-target REMOVE _CRT_SECURE_NO_WARNINGS)
#
# will prevent `_CRT_SECURE_NO_WARNINGS` from being passed to the compiler as a
# defined symbol for sample-target only.
#
# Similarly extra definitions can be added by passing ADD followed by a list of
# symbols (or definitions in the form of symbol=value), eg:
#
# asap_set_compile_definitions(sample-target ADD SUPER HERO=2)
#
# will pass SUPER and HERO=2 to the compiler as definitions for sample-target
# only.
#
# When linking against the contract checking and enforcement library
# `asap-contract` (https://github.com/asap-projects/asap-contract), it is
# possible to control the contract checking mode by passing a value for the
# `CONTRACTS` option to this function as follows:
#
# * CONTRACTS OFF     : set contract checking mode to OFF
# * CONTRACTS AUDIT   : set contract checking mode to AUDIT
# * CONTRACTS DEFAULT : set contract checking mode to DEFAULT
#
# * CONTRACTS AUTO    : set contract checking mode using as a first priority the
#   value passed in the cmake option `OPTION_CONTRACT_MODE`. If none is present,
#   automatically set the mode based on the build configuration. For Debug ->
#   AUDIT, For Release and RelMinSize -> OFF, and for RelWithDebInfo -> DEFAULT.
#
# * CONTRACTS TESTING : indicates that contracts are being testing and the
#   target needs to have full control on the contract checking mode. Nothing
#   will be done here.
#
# The default setting is AUTO.
# ------------------------------------------------------------------------------

function(asap_set_compile_definitions target)
  set(argOption "")
  set(argSingle "CONTRACTS")
  set(
    argMulti
    "ADD"
    "REMOVE"
  )

  unset(x_CONTRACTS)
  unset(x_ADD)
  unset(x_REMOVE)

  cmake_parse_arguments(x "${argOption}" "${argSingle}" "${argMulti}" ${ARGN})
  if(NOT DEFINED x_CONTRACTS OR x_CONTRACTS STREQUAL "")
    set(x_CONTRACTS "AUTO")
  endif()

  set(all_definitions)

  # Provide a way to distinguish between debug and release builds via
  # preprocessor define
  list(APPEND all_definitions "$<$<CONFIG:Debug>:ASAP_IS_DEBUG_BUILD>")

  if(MSVC)
    list(
      APPEND
      all_definitions
      "NOMINMAX"
      "WIN32_LEAN_AND_MEAN=1"
      "_WIN32_WINNT=0x0600"
    )
    # Disabling warning for not using "secure-but-not-standard" STL algos
    list(
      APPEND
      all_definitions
      "_CRT_SECURE_NO_WARNINGS"
      "_SCL_SECURE_NO_WARNINGS"
    )
  endif()

  if(x_REMOVE)
    foreach(definition ${x_REMOVE})
      list(FIND all_definitions ${definition} found)
      if(found EQUAL -1)
        message(
          FATAL_ERROR
          "Compiler definition '${definition}' specified for removal is not "
          "part of the set of common compiler definitions."
        )
      endif()
    endforeach()
    list(REMOVE_ITEM all_definitions ${x_REMOVE})
  endif()

  list(APPEND all_definitions ${x_ADD})

  target_compile_definitions(${target} PRIVATE ${all_definitions})

  # If linking against asap_contract, set the contract checking mode. Use
  # generator expressions only, do not check for CMAKE_BUILD_TYPE which is not
  # friendly with multi-config generators.
  if(NOT x_CONTRACTS STREQUAL "TESTING")
    if(x_CONTRACTS MATCHES "OFF|AUDIT|DEFAULT")
      target_compile_definitions(${target} PRIVATE "ASAP_CONTRACT_${x_CONTRACTS}")
    elseif(x_CONTRACTS STREQUAL "AUTO")
      if(NOT DEFINED OPTION_CONTRACT_MODE)
        target_compile_definitions(
          ${target}
          PRIVATE
            $<$<CONFIG:Debug>:ASAP_CONTRACT_AUDIT>
            $<$<CONFIG:RelWithDebInfo>:ASAP_CONTRACT_DEFAULT>
            $<$<CONFIG:Release,RelMinSize>:ASAP_CONTRACT_OFF>
        )
      else()
        target_compile_definitions(${target} PRIVATE "ASAP_CONTRACT_${OPTION_CONTRACT_MODE}")
      endif()
    else()
      message(
        FATAL_ERROR
        "Contract mode '${x_CONTRACTS}' is not valid."
        "Valid values are: OFF, DEFAULT, AUDIT, AUTO and TESTING."
      )
    endif()
  endif()
endfunction()
