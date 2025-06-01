# Determine if this is built as a subproject  or if it is the master project.

if(NOT DEFINED ${META_PROJECT_ID}_INSTALL)
  option(${META_PROJECT_ID}_INSTALL "Generate the install target for this project." ${${META_PROJECT_ID}_IS_MASTER_PROJECT})
endif()

macro(_setup_install_dirs)
  message(STATUS "Using CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
  # Check for system dir install
  set(_system_dir_install FALSE)
  if("${CMAKE_INSTALL_PREFIX}" STREQUAL "/usr" OR "${CMAKE_INSTALL_PREFIX}" STREQUAL "/usr/local")
    set(_system_dir_install TRUE)
  endif()

  # cmake-format: off
  if(UNIX AND _system_dir_install)
    # Installation paths
    include(GNUInstallDirs)
    # Install into the system (/usr/bin or /usr/local/bin)
    set(ASAP_INSTALL_LIB "${CMAKE_INSTALL_LIBDIR}") # /usr/[local]/lib
    set(ASAP_INSTALL_SHARED "${ASAP_INSTALL_LIB}") # /usr/[local]/lib
    set(ASAP_INSTALL_CMAKE "${CMAKE_INSTALL_DATAROOTDIR}/cmake/${META_PROJECT_NAME}") # /usr/[local]/share/cmake/<project>
    set(ASAP_INSTALL_PKGCONFIG "${CMAKE_INSTALL_DATAROOTDIR}/pkgconfig") # /usr/[local]/share/pkgconfig
    set(ASAP_INSTALL_EXAMPLES "${CMAKE_INSTALL_DATAROOTDIR}/${META_PROJECT_NAME}/examples") # /usr/[local]/share/<project>/examples
    set(ASAP_INSTALL_DATA "${CMAKE_INSTALL_DATAROOTDIR}/${META_PROJECT_NAME}") # /usr/[local]/share/<project>
    set(ASAP_INSTALL_BIN "${CMAKE_INSTALL_BINDIR}") # /usr/[local]/bin
    set(ASAP_INSTALL_INCLUDE "${CMAKE_INSTALL_INCLUDEDIR}") # /usr/[local]/include
    set(ASAP_INSTALL_DOC "${CMAKE_INSTALL_DOCDIR}") # /usr/[local]/share/doc/<project>
    set(ASAP_INSTALL_SHORTCUTS "${CMAKE_INSTALL_DATAROOTDIR}/applications") # /usr/[local]/share/applications
    set(ASAP_INSTALL_ICONS "${CMAKE_INSTALL_DATAROOTDIR}/pixmaps") # /usr/[local]/share/pixmaps
    set(ASAP_INSTALL_INIT "/etc/init") # /etc/init (upstart init scripts)
    set(ASAP_INSTALL_MISC "${CMAKE_INSTALL_DATAROOTDIR}/${META_PROJECT_NAME}") # /etc/init (upstart init scripts)
  else()
    # Install into local directory
    set(ASAP_INSTALL_LIB "${CMAKE_INSTALL_PREFIX}/lib") # ./lib
    set(ASAP_INSTALL_SHARED "${ASAP_INSTALL_LIB}") # ./lib
    set(ASAP_INSTALL_CMAKE "${CMAKE_INSTALL_PREFIX}/share/cmake/${META_PROJECT_NAME}") # ./share/cmake/<project>
    set(ASAP_INSTALL_PKGCONFIG "${CMAKE_INSTALL_PREFIX}/share/pkgconfig") # ./share/pkgconfig
    set(ASAP_INSTALL_EXAMPLES "${CMAKE_INSTALL_PREFIX}/examples") # ./examples
    set(ASAP_INSTALL_DATA "${CMAKE_INSTALL_PREFIX}") # ./
    set(ASAP_INSTALL_BIN "${CMAKE_INSTALL_PREFIX}/bin") # ./bin
    set(ASAP_INSTALL_INCLUDE "${CMAKE_INSTALL_PREFIX}/include") # ./include
    set(ASAP_INSTALL_DOC "${CMAKE_INSTALL_PREFIX}/doc") # ./doc
    set(ASAP_INSTALL_SHORTCUTS "${CMAKE_INSTALL_PREFIX}/shortcuts") # ./shortcuts
    set(ASAP_INSTALL_ICONS "${CMAKE_INSTALL_PREFIX}/icons") # ./icons
    set(ASAP_INSTALL_INIT "${CMAKE_INSTALL_PREFIX}/init") # ./init
    set(ASAP_INSTALL_MISC "${CMAKE_INSTALL_PREFIX}") # ./
  endif()
  # cmake-format: on
endmacro()

if(${META_PROJECT_ID}_INSTALL)
  # By default we only add the install target if this is the master project. If
  # it is used as a sub-project, then the user can request to add the install
  # targets by overriding this option.

  _setup_install_dirs()

  if(NOT ${META_PROJECT_ID}_IS_MASTER_PROJECT)
    return()
  endif()

  set(runtime "${META_PROJECT_NAME}_runtime")
  set(dev "${META_PROJECT_NAME}_dev")
  set(meta "${META_PROJECT_NAME}_meta")
  set(data "${META_PROJECT_NAME}_data")
  set(docs "${META_PROJECT_NAME}_docs")

  # Install the project meta files
  install(FILES AUTHORS DESTINATION ${ASAP_INSTALL_MISC} COMPONENT ${meta})
  install(FILES LICENSE DESTINATION ${ASAP_INSTALL_MISC} COMPONENT ${meta})
  install(FILES README.md DESTINATION ${ASAP_INSTALL_MISC} COMPONENT ${meta})

  # Install generated header files
  install(
    DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/include/${META_PROJECT_ID_LOWER}
    DESTINATION ${ASAP_INSTALL_INCLUDE}
    COMPONENT ${dev}
  )

  # Install master docs
  string(MAKE_C_IDENTIFIER ${META_PROJECT_NAME} project_id)
  string(TOLOWER ${project_id} project_id)
  set(master_sphinx_target ${project_id}_master)
  install(DIRECTORY ${SPHINX_BUILD_DIR}/${master_sphinx_target} DESTINATION ${ASAP_INSTALL_DOC} COMPONENT ${docs} OPTIONAL)

  # Install data
  install(DIRECTORY ${PROJECT_SOURCE_DIR}/data DESTINATION ${ASAP_INSTALL_DATA} COMPONENT ${data} OPTIONAL)
endif()
