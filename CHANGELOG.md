# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [4.8.0](https://github.com/abdes/asap/compare/v4.7.0...v4.8.0) (2025-06-01)


### Features

* add GitHub Actions workflow for release-please automation ([69d96da](https://github.com/abdes/asap/commit/69d96dad7cc56570067f825b420e1dabc4270693))
* customize release-please workflow ([b3504fb](https://github.com/abdes/asap/commit/b3504fbfc033deebc8d7fc578e3e7c160d42b927))
* customize release-please workflow to update versions ([c4921d6](https://github.com/abdes/asap/commit/c4921d64bcc979b45f58933813155c1d38ec9bbb))
* support for qualified module names ([0c01c12](https://github.com/abdes/asap/commit/0c01c1222b0bf5877811ff19f2626163f7cc9e40))
* use pre-commit instead of husky ([551e1a1](https://github.com/abdes/asap/commit/551e1a16e3c106d0e48629932fc5121de86f83ec))


### Bug Fixes

* add .python-version to .gitignore ([9c8957c](https://github.com/abdes/asap/commit/9c8957c833e6553daa1f6e8c8584b318fc78aef9))
* add 'Ninja' generator to macos-builds workflow ([32bcb28](https://github.com/abdes/asap/commit/32bcb28b97d3c904a1dd2841aa28602293cbf718))
* allow project options to be overriden from master projects or command line ([2812446](https://github.com/abdes/asap/commit/2812446053301c9ebb6ff0ce5a37a74a95535d8d))
* api export generated header does not respect project layout ([571ac3f](https://github.com/abdes/asap/commit/571ac3f7b24b1805ebad46c3ccf38b13aeee72ae))
* create .clangd only if it does not exists ([8942178](https://github.com/abdes/asap/commit/8942178bb3e6049bcc5e75863982a03698e3fd2d))
* enable docs build for pages ([010fc52](https://github.com/abdes/asap/commit/010fc52841c19585508f5337072bc323dfaea598))
* generate version numbers as numbers ([b3491d1](https://github.com/abdes/asap/commit/b3491d149dd2272f6bc547d4970e3cc34128e5cf))
* honor the options to disable doc, docygen, sphinx ([2d66564](https://github.com/abdes/asap/commit/2d66564ba97a3fbcf0ea5b856dad801a8718796f))
* main.cpp generation fails when multiple build configs are running ([e7eb314](https://github.com/abdes/asap/commit/e7eb31400ef177d7d161501bc209005721d354f2))
* remove unnecessary esbonio settings ([5f5ada2](https://github.com/abdes/asap/commit/5f5ada26c0c1a1204aa056c90180e2e866b7db03))
* remove Xcode generator from macos-builds workflow ([fde6a3b](https://github.com/abdes/asap/commit/fde6a3b79554a218834aaf8b816b2c371c74beed))
* remove Xcode setup step from macos-builds workflow ([a97b42a](https://github.com/abdes/asap/commit/a97b42ac48902e7f23d98e6d8fecc2a1eff91e9c))
* sphinx generation targets not properly setup ([a06b9a1](https://github.com/abdes/asap/commit/a06b9a177ca551849be712552424c578e1953f8d))
* update actions to latest versions in workflows ([dac90de](https://github.com/abdes/asap/commit/dac90de17a92b1be90b46090070d0c0a1ce912a4))
* update branch name from main to master in release workflow ([802960e](https://github.com/abdes/asap/commit/802960e6e314b86b0437cd983daf09a6c314e4d2))
* update GitHub Actions to use latest versions of actions and Python ([52c983d](https://github.com/abdes/asap/commit/52c983dbae057a217e2e45bc00aa73d31b8cf31b))
* update GitHub Actions to use latest versions of actions and Python ([40cc904](https://github.com/abdes/asap/commit/40cc90402c07c4cefbcad5077a0c967c4b280ca7))
* update macos workflow and fix issues ([7575f81](https://github.com/abdes/asap/commit/7575f8109d44a6113b96bdee0c342ec67d0814e9))
* update Xcode versions in macos-builds workflow ([f93fc1f](https://github.com/abdes/asap/commit/f93fc1f8dceb067ad82de623a3cf3b3775afc7b5))
* use swift common for clang format/tidy and gersemi for cmake format ([dc22af9](https://github.com/abdes/asap/commit/dc22af91ba2fdcf8eb60542644949d6ede44a388))

## [4.7.0](http://github.com/abdes/asap/compare/v4.6.3...v4.7.0) (2024-01-29)

### Features

- add build option to enable or disable docs targets ([481c240](http://github.com/abdes/asap/commit/481c24087a23ad551e3ccccd260fa4896c963c2c))
- comprehensive macos builds for CI ([084ae86](http://github.com/abdes/asap/commit/084ae866e16a7999c8612599610c385e0e555321))
- comprehensive ubuntu builds for CI ([27fce46](http://github.com/abdes/asap/commit/27fce464c0664d160a519908898cc71d6ba95980))
- comprehensive windows builds for CI ([e46196f](http://github.com/abdes/asap/commit/e46196f7daf138c2fd33248fbc0593367149480b))
- custom index.html should be optional in project doc root ([9f906fd](http://github.com/abdes/asap/commit/9f906fd88181bcb75132fc4a6f8127538a58f22a))
- upgrade CPM to 0.38.1 ([b333b38](http://github.com/abdes/asap/commit/b333b3858c204fa2151171f0ac494853089ffa37))

### Bug Fixes

- always include CTest even when ASAP_BUILD_TESTS is OFF ([4c5ef88](http://github.com/abdes/asap/commit/4c5ef88ab79bd1ad50b68e1cc2a41fc16ce73613))

### Documentation

- configure project folders for esbonio extension ([3adbff4](http://github.com/abdes/asap/commit/3adbff481b90e7c8398752e6c3489ed5b12f91c9))
- there are no library modules anymore ([53e34e2](http://github.com/abdes/asap/commit/53e34e2f65f283f60f782b534701a6552db5b7fd))
- update for in-module or in-root sphinx docs ([d2c0fe4](http://github.com/abdes/asap/commit/d2c0fe46942871b47e758dc9f5bfe7a73412bc6e))
- update sphinx theme option to new name ([a78e49a](http://github.com/abdes/asap/commit/a78e49a78c868473a724d0357eeaee37a5a75201))
- update url for executable books logo ([8b4dd17](http://github.com/abdes/asap/commit/8b4dd1739bfbfe057437bd3e96b5b29adf98fd1a))

## [4.6.3](http://github.com/abdes/asap/compare/v4.6.2...v4.6.3) (2023-03-25)

### Enhancements

- Simplify `devcontainer` setup by using features and additional container
  lifecycle commands.

### Bug Fixes

- enable profiling for test coverage for MSVC ([7348d0a](http://github.com/abdes/asap/commit/7348d0a36b05b2f2e9c517e5b981f2c218bd511e)), closes [#22](http://github.com/abdes/asap/issues/22)

## [4.6.2](http://github.com/abdes/asap/compare/v4.6.1...v4.6.2) (2022-11-28)

### Features

- increase ccache hit rate ([a22a912](http://github.com/abdes/asap/commit/a22a91226060851fe9fc7e5bc0e51973df94d95c))
- more robust handling of contract checking mode ([304e9ae](http://github.com/abdes/asap/commit/304e9aee1e8fb265be78163578c45ae22569e52b))

  When linking against the contract checking and enforcement library
  `asap-contract` (https://github.com/asap-projects/asap-contract), it is
  possible to control the contract checking mode by passing a value for the
  `CONTRACTS` option when adding any type of target with `asap_add_xxx`
  API (e.g. asap_add_library. asap_add_test, etc):

  - CONTRACTS OFF : set contract checking mode to OFF
  - CONTRACTS AUDIT : set contract checking mode to AUDIT
  - CONTRACTS DEFAULT : set contract checking mode to DEFAULT

  - CONTRACTS AUTO : set contract checking mode using as a first priority the
    value passed in the cmake option `OPTION_CONTRACT_MODE`. If none is present,
    automatically set the mode based on the build configuration. For Debug ->
    AUDIT, For Release and RelMinSize -> OFF, and for RelWithDebInfo -> DEFAULT.

  - CONTRACTS TESTING : indicates that contracts are being testing and the
    target needs to have full control on the contract checking mode. Nothing
    will be done here.

  The default setting is AUTO.

### Bug Fixes

- **build:** [#21](http://github.com/abdes/asap/issues/21) target option `WARNING` not propagated properly ([432cdaf](http://github.com/abdes/asap/commit/432cdaff1e5c8775d0d5c533dd0abe5eac229bd7))

  By default, for every target we build, a compiler option will be added
  to treat warnings as errors, unless the target is added with `WARNING` as
  an option.

  When that option is used, we now properly propagate it to set the
  corresponding compiler option to **NOT** treat warnings as errors.

  This is useful when 3rd party dependencies have include files that
  generate warnings.

## [4.6.1](http://github.com/abdes/asap/compare/v4.6.0...v4.6.1) (2022-09-20)

### Bug Fixes

- always add code coverage 'all' targets ([d7309a0](http://github.com/abdes/asap/commit/d7309a0806e11a46c73b700f12bccb424c62839b))
- version-info test was added even when ASAP_BUILD_TESTS is OFF ([b566e7b](http://github.com/abdes/asap/commit/b566e7b555ffb40f8ab1eea43d9a965c5724ccf1))

## [4.6.0](http://github.com/abdes/asap/compare/v4.5.2...v4.6.0) (2022-09-20)

### Features

- option to control the use of ccache, default is OFF ([49a17a9](http://github.com/abdes/asap/commit/49a17a99026ae7e59d14297d01ed2f8d10c78762))

  More robust implementation of fatser builds with `ccache`. Caching is enabled in
  GitHub CI builds and can be enabled in development environments by simply
  setting the cmake variable `USE_CCACHE` to 'ON'/'TRUE' or equivalent.

  A precondition for the environment is of course to have `ccache` installed,
  which gets done automatically in GitHub workflows, but needs to be done in
  development environments. It is recommended to use brew/choco for MacOS/Windows,
  but to install from the pre-built binaries for Linux as the version that comes
  with most distros is quite old.

  It is to be noted that `ccache` with MSVC on Windows may have some issues and if
  that is the case, simply do not use it.

### [4.5.2](http://github.com/abdes/asap/compare/v4.5.1...v4.5.2) (2022-09-20)

### Bug Fixes

- sub-projects with tests fail due to coverage all target not being setup early enough ([400b2cc](http://github.com/abdes/asap/commit/400b2ccc120bd4f2c4d70f48fd3f94ce7a3f6de0))

## [4.5.1](http://github.com/abdes/asap/compare/v4.5.0...v4.5.1) (2022-09-19)

### Bug Fixes

- contract mode definition should only be added when not testing asap_contract ([c6d5e34](http://github.com/abdes/asap/commit/c6d5e342e7a74236bb1b006be1e0d6bfe956a51a))
- use correct path for the version include file ([7997b68](http://github.com/abdes/asap/commit/7997b68eeef236e6940b0ba168c79dbdd21b34ad))

## [4.5.0](http://github.com/abdes/asap/compare/v4.4.8...v4.5.0) (2022-09-19)

### Features

1. **`version-info` tool**

   Add the `version-info` tool to print the project info ([cb228e8](http://github.com/abdes/asap/commit/cb228e8af73fbf063371e4c597f757bf5e9a4b75))

   This tool uses the generated `version.h` file in a small C++ program
   to print the project's info, as defined in the project's master
   `CMakeLists.txt`.

   It also constitutes an example of how to use the `version.h` file and
   a simple test to check that the `asap` infrastructure for defining and
   building targets is working.

2. **More visibility on project/module nesting**

   Enhance configure logs with project/module nesting hierarchy ([f6c13f2](http://github.com/abdes/asap/commit/f6c13f2a08c89cac57fb2f0dd857c8f382e50e7b))

   Track the projects/modules nesting level with a hierarchy stack updated
   when we enter/exit a project/module. Most of the management is done
   automatically as helper functions get called to add modules or external
   packages. Some of the boilerplate (minimal) is still manual:

   - In the top-level `CMakeLists.txt`, the project needs to pushed at the
     beginning and popped at the end.
   - In each module `CMakeLists.txt`, the module needs to be pushed at
     the start and popped at the end.

   Use the `ASAP_LOG_PROJECT_HIERARCHY` to get a string that contains
   the nesting hierarchy.

3. **Formatting**

   Implement robust project-wide formatting ([afcaebe](http://github.com/abdes/asap/commit/afcaebe544fc03684ae2f85d8507b1f4571d989b))

   Now we can format cmake files with cmake-format and any of the file
   types supported by clang-format (including C++, JavaScript and Json)
   with clang-format.

   The following additional targets are defined:

   - format Shows which files are affected by clang-format
   - check-format errors if files are affected by clang-format (for CI)
   - fix-format Applies clang-format to all affected files

   Dedicated targets for each of `cmake-format` and `clang-format`
   are also added (e.g. cmake-format, clang-format, check-clang-format,...)

### Bug Fixes

- generated `version.h` should follow project naming ([329bcdf](http://github.com/abdes/asap/commit/329bcdfc8cb9ba4782d0cbf4b3f21ad677307644))
- install master project generated header files ([3c5c162](http://github.com/abdes/asap/commit/3c5c1628b3c920e52200f7e14ecde2346b78a6f4))

### Documentation

- add example output from version-info tool ([3a5515e](http://github.com/abdes/asap/commit/3a5515e74b0b0e5c06ba7e4500f7572a3bc4450f))
- update after new formatting system ([082e513](http://github.com/abdes/asap/commit/082e5134fd7d1cd03cc06218e10d5cf978b22409))

## [4.4.8](http://github.com/abdes/asap/compare/v4.4.7...v4.4.8) (2022-09-18)

### Bug Fixes

- restore test setup deleted by mistake ([cec7b9d](http://github.com/abdes/asap/commit/cec7b9d92481d1480c54610892cbfd954b9e0068))

## [4.4.7](http://github.com/abdes/asap/compare/v4.4.6...v4.4.7) (2022-09-18)

- Refactor cmake common modules and the master cmake script to better work with
  sub-projects built with `asap`.
- Reduce the verbosity of some actions and avoid re-running things when not
  needed.

## [4.4.6](http://github.com/abdes/asap/compare/v4.4.5...v4.4.6) (2022-09-18)

### Bug Fixes

- top level install not working properly ([4ac4a31](http://github.com/abdes/asap/commit/4ac4a31001a2ab73764e3d9fe3f279b1e7b25aee))

  `CMAKE_MODULE_PATH` should be reset at the top level project to make sure that
  every sub-project uses its own version of the `cmake` files. Additionally,
  refactor the top-level install code to simplify it and remove the need to call
  a function in the top-level project `cmake` script.

## [4.4.5](http://github.com/abdes/asap/compare/v4.4.4...v4.4.5) (2022-09-18)

### Bug Fixes

- [#20](http://github.com/abdes/asap/issues/20) local install should use CMAKE_INSTALL_PREFIX to set variables ([2e1f1d4](http://github.com/abdes/asap/commit/2e1f1d49baff64dbf47dbbda234886ad2dfdbf1c))
- [#20](http://github.com/abdes/asap/issues/20) use CMAKE_INSTALL_PREFIX to set variables ([2fffd96](http://github.com/abdes/asap/commit/2fffd96392114993bbb72e3f614725f867d61ab1))
- wrong variable used of target name ([04b5343](http://github.com/abdes/asap/commit/04b5343ae541bd6d4f5ae1c1fa2eb85b93e0b5a3))

## [4.4.4](http://github.com/abdes/asap/compare/v4.4.3...v4.4.4) (2022-09-18)

### Bug Fixes

- wrong variable used for target name ([04b5343](http://github.com/abdes/asap/commit/04b5343ae541bd6d4f5ae1c1fa2eb85b93e0b5a3))

## [4.4.3](http://github.com/abdes/asap/compare/v4.4.2...v4.4.3) (2022-09-18)

### Bug Fixes

- [#19](http://github.com/abdes/asap/issues/19) use generator expressions instead of CMAKE_BUILD_TYPE ([857d299](http://github.com/abdes/asap/commit/857d2997d4ec6c879036e10234b8baf907e91089))

  Code that checks CMAKE_BUILD_TYPE to set specific compiler flags or defines is
  problematic. Generator expressions should be used instead to handle
  configuration-specific logic correctly, regardless of the generator used.

- use cmake-format extension default behavior ([a5d5c5e](http://github.com/abdes/asap/commit/a5d5c5eae39e4d3d0094c00848cfe777d331a219))

  No need to force the `cmake-format` config file location as the command is run
  in the workspace root by default and it will look for and find the config file
  named `cmake-format.yaml`.

## [4.4.2](http://github.com/abdes/asap/compare/v4.4.1...v4.4.2) (2022-09-16)

### Bug Fixes

- [#13](http://github.com/abdes/asap/issues/13) move "caexcludepath" to dev-windows and exclude CPM cache ([0571714](http://github.com/abdes/asap/commit/0571714e9436bfec26d6450b5bc37f2a5f478a55))
- [#14](http://github.com/abdes/asap/issues/14) upgrade CPM to 0.35.6
  ([695414b](http://github.com/abdes/asap/commit/695414b8e66d4d42d7ef3aaef3c6a4b8399d16c2))
- [#15](http://github.com/abdes/asap/issues/15) get target type before testing it ([b8bd378](https://github.com/abdes/asap/commit/b8bd378f52bc131b84c13b08cfe70d649e9d9be0))
- [#16](http://github.com/abdes/asap/issues/16) use CMAKE_CURRENT_SOURCE_DIR instead of CMAKE_SOURCE_DIR for cmake includes ([4ac6928](http://github.com/abdes/asap/commit/4ac6928fc2a0bf806bbcaa3bea898b5ff018a164))
- [#17](http://github.com/abdes/asap/issues/17) git should not be required ([2c76104](http://github.com/abdes/asap/commit/2c761046d0801f643aa0215d34f2795ff0093dfc))
- [#18](http://github.com/abdes/asap/issues/18) enforce end of line to LF ([943ae47](http://github.com/abdes/asap/commit/943ae479e09de999c324a9cfe3bbf8d688d255a3))

## [4.4.1](http://github.com/abdes/asap/compare/v4.4.0...v4.4.1) (2022-08-20)

### Bug Fixes

- [#12](http://github.com/abdes/asap/issues/12) disable used-but-marked-unused
  ([6d42d83](http://github.com/abdes/asap/commit/6d42d83bfdd16123f05a69726058dc5f103143be))

  For clang-tidy, this check generates many errors with google test framework
  and as such is not worth the trouble.

## [4.4.0](http://github.com/abdes/asap/compare/v4.3.6...v4.4.0) (2022-08-20)

### Bug Fixes

- [#10](http://github.com/abdes/asap/issues/10) no more template export header
  ([dd8ffd5](http://github.com/abdes/asap/commit/dd8ffd5a8f36340963349c7ebcb7c1713c2f880a)).

  Simply include the `asap_<module>_export.h` which defines the
  `ASAP_<MODULE>_API` macros for symbol visibility. As a general rule, do not
  add explicit visibility for inline methods/functions and for template
  classes/functions as they are included in each compilation unit.

- [#11](http://github.com/abdes/asap/issues/11) refactor compiler options
  management.
  ([78ae493](http://github.com/abdes/asap/commit/78ae4933f2e263a55f6537e66347c6b11a24b961))

  In general, asap target helpers, such as asap_add_library, will seamlessly
  manage compiler options behind the scenes, relaying first to `cmake/common`
  modules and then overriding/adding/removing options based on asap preferences.
  Such options can further be customized by the calling module using the
  `asap_set_compile_options()` function and passing `ADD`, `REMOVE` and relevant
  options as appropriate.

- [#9](http://github.com/abdes/asap/issues/9) remove no longer used function
  ([5a7416f](http://github.com/abdes/asap/commit/5a7416f9563aae303d68ca2bb878fef97fbb7130))

## [4.3.6](http://github.com/abdes/asap/compare/v4.3.5...v4.3.6) (2022-08-11)

Minor update to directly use the `cmake/common` submodule from
<https://github.com/swift-nav/cmake> now that all asap fixes have been merged over
there.

## [4.3.5](http://github.com/abdes/asap/compare/v4.3.4...v4.3.5) (2022-08-11)

### Bug Fixes

- **#6:** properly setup install layout
  ([71fd5d5](http://github.com/abdes/asap/commit/71fd5d5ee6f4694a8d7d6994e3a09d5b2f18ce24)),
  closes [#6](http://github.com/abdes/asap/issues/6)

  When the install prefix matches a system install directory (i.e. /usr or
  /usr/local), the project will be installed according to the conventions of
  [GnuInstallDirs](https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html),
  otherwise, it will be installed using a simplified local layout as following:

```cmake
    # Install into local directory
    set(ASAP_INSTALL_ROOT      ".")                                           # ./
    set(ASAP_INSTALL_LIB       "lib")                                         # ./lib
    set(ASAP_INSTALL_SHARED    "${ASAP_INSTALL_LIB}")                         # ./lib
    set(ASAP_INSTALL_CMAKE     "${ASAP_INSTALL_ROOT}/share/cmake/${META_PROJECT_NAME}") # ./share/cmake/<project>
    set(ASAP_INSTALL_PKGCONFIG "${ASAP_INSTALL_ROOT}/share/pkgconfig")        # ./share/pkgconfig
    set(ASAP_INSTALL_EXAMPLES  "${ASAP_INSTALL_ROOT}")                        # ./
    set(ASAP_INSTALL_DATA      "${ASAP_INSTALL_ROOT}")                        # ./data
    set(ASAP_INSTALL_BIN       "bin")                                         # ./bin
    set(ASAP_INSTALL_INCLUDE   "include")                                     # ./include
    set(ASAP_INSTALL_DOC       "doc")                                         # ./doc
    set(ASAP_INSTALL_SHORTCUTS "misc")                                        # ./misc
    set(ASAP_INSTALL_ICONS     "misc")                                        # ./misc
    set(ASAP_INSTALL_INIT      "misc")                                        # ./misc
```

- **#7:** add `build` and `ops` commit types
  ([0d9187e](http://github.com/abdes/asap/commit/0d9187e9d20788d3f0c5048bcb4deca4cf5280e3)),
  closes [#7](http://github.com/abdes/asap/issues/7)

  Added the following two commit types:

  - `build` Commits, that affect build components like build tool, ci pipeline,
    dependencies, project version, ...
  - `ops` Commits, that affect operational components like infrastructure,
    deployment, backup, recovery, ...

- **#8:** add standard ccov excluded directories by default
  ([a8aabb3](http://github.com/abdes/asap/commit/a8aabb31d3ea6b0c5a50e13bf366f092ca724537)),
  closes [#8](http://github.com/abdes/asap/issues/8)

  The standard exclusions are:

  - anything matching `*/test/*` in its path, i.e. files used to write tests,
  - anything located inside `*/.cache/CPM/*`, i.e. third party modules included
    using CPM,
  - anything under `/usr`, i.e. system files

## [4.3.4](http://github.com/abdes/asap/compare/v4.3.3...v4.3.4) (2022-08-04)

### Bug Fixes

- alias variable to enable/disable building tests
  ([3992b0f](http://github.com/abdes/asap/commit/3992b0f7d500e653532bd0f206489058d99ad2d0))
- typo in variable name to enable/disable building tests
  ([9950fe2](http://github.com/abdes/asap/commit/9950fe2dcbe6c284e9ce32ce6a455e4a3a499ec4))

## [4.3.3](http://github.com/abdes/asap/compare/v4.3.2...v4.3.3) (2022-08-04)

### Bug Fixes

- add aliases used by cmake common functions
  ([9c33906](http://github.com/abdes/asap/commit/9c339069acd9ab6355f8156f2e8eaf81c382342c))

## [4.3.2](http://github.com/abdes/asap/compare/v4.3.1...v4.3.2) (2022-08-04)

### Bug Fixes

- [#5](http://github.com/abdes/asap/issues/5) update cmake/common to latest
  ([5034b22](http://github.com/abdes/asap/commit/5034b22d39e5cb54acd51baa0bf815dbdd82093b))

## [4.3.1](http://github.com/abdes/asap/compare/v4.3.0...v4.3.1) (2022-05-01)

### Features

- add ccache support to dev container
  ([202c27a](http://github.com/abdes/asap/commit/202c27a628f7f35ae17f2df91c1d95f67360abea))

## [4.3.0](http://github.com/abdes/asap/compare/v4.2.0...v4.3.0) (2022-04-07)

### Documentation

- add badge for OpenSSF best practices
  ([26c01c8](http://github.com/abdes/asap/commit/26c01c8bcf98c6b47e6622dea91a6c6e10bc978c))
- add CPM as preferred way of managing third party deps
  ([5a33f70](http://github.com/abdes/asap/commit/5a33f70a15a64c84f0a13b4286460f9df20459a5))
- add tutorial videos
  ([cb13248](http://github.com/abdes/asap/commit/cb13248244cddd0dc2c187893556fad7aa4f08b7))
- fix thumbnail and links of project docs video
  ([1a6269e](http://github.com/abdes/asap/commit/1a6269eef8999504aba8105d4c446a93e41c988b))
- how to report security vulnerabilities
  ([46426e9](http://github.com/abdes/asap/commit/46426e9d44f3c4e8ee0b3fdd98e2ee56d13f8890))
- improve the key features section
  ([79119ba](http://github.com/abdes/asap/commit/79119ba52f578a28dfdeb1ce59bba67c3fbcd3c1))
- include build status badges for all branches
  ([2b98ae1](http://github.com/abdes/asap/commit/2b98ae11ace8fa756c825686018a3a328ce27eca))
- revamp the project README
  ([e72c4c3](http://github.com/abdes/asap/commit/e72c4c3288d565b34b137ab785abe90370052258))
- rewrite the contributing section
  ([c7e39c4](http://github.com/abdes/asap/commit/c7e39c4cfa6033aac42befe5ed994089e601b6a0))
- update instructions for repo from template scenario
  ([1cafdb5](http://github.com/abdes/asap/commit/1cafdb57f86a4b61a736b3411791ae96ca684f33))
- update project docs video
  ([c7f79fc](http://github.com/abdes/asap/commit/c7f79fc64900cfa9ec3d2466300d1d32830b32f1))

## [4.2.0](http://github.com/abdes/asap/compare/v4.1.8...v4.2.0) (2022-04-03)

### Features

- make ccache usable on all platforms
  ([412730f](http://github.com/abdes/asap/commit/412730f86679d7ccd350cadf5649b7a489376cae))

### Bug Fixes

- use only white-listed properties for interface library
  ([227de02](http://github.com/abdes/asap/commit/227de026878beb9dd9679d0cad12cf25bce16c4a))

## [4.1.8](http://github.com/abdes/asap/compare/v4.1.7...v4.1.8) (2022-03-15)

- chore: use [CPM](https://github.com/cpm-cmake/CPM.cmake#adding-cpm) for
  dependency management
- chore: use ccache to speedup build

## [4.1.7](http://github.com/abdes/asap/compare/v4.1.6...v4.1.7) (2022-03-06)

docs: add last-updated-on timestamp

## [4.1.6](http://github.com/abdes/asap/compare/v4.1.5...v4.1.6) (2022-03-06)

### Bug Fixes

- define asap_top_level_install as empty when project install should be skipped
  ([616deed](http://github.com/abdes/asap/commit/616deed7f2655cf6690135ed1914f7eec8053373))
- use correct links for documentation
  ([486144c](http://github.com/abdes/asap/commit/486144c46222c22861b0a14f9dc002d148a31f24)),
  closes [#4](http://github.com/abdes/asap/issues/4)

## [4.1.5](http://github.com/abdes/asap/compare/v4.1.4...v4.1.5) (2022-03-06)

chore: force shell to bash on all platforms

## [4.1.4](http://github.com/abdes/asap/compare/v4.1.3...v4.1.4) (2022-03-06)

chore: adjust command for windows powershell

## [4.1.3](http://github.com/abdes/asap/compare/v4.1.2...v4.1.3) (2022-03-06)

Update artifact names in build matrix for automatic release.

## [4.1.2](http://github.com/abdes/asap/compare/v4.1.1...v4.1.2) (2022-03-06)

This is a refactoring release to trim down the template project to the minimum
and streamline the generated targets.

### Bug Fixes

- always use top level build dir for output
  ([1b01db2](http://github.com/abdes/asap/commit/1b01db2402bc52944646bcde3cf525315a4e0e1b))
- doxygen and sphinx target conflict with modules
  ([02375ff](http://github.com/abdes/asap/commit/02375ff4a33e34a8e0cb9307ef4eb6de3271e945))
- generate doc only if project is master
  ([82190fa](http://github.com/abdes/asap/commit/82190fa6562f5e51dbbab660bcab8dc265e99a0b))
- make doxygen targets sub-project friendly
  ([546fe73](http://github.com/abdes/asap/commit/546fe73ded53721dddbac311e9db41e4146b8ad2))
- make gtest work again
  ([3ce658c](http://github.com/abdes/asap/commit/3ce658c5f1eb216a3286717e7f80827b96ff3b49))
- make sphinx targets sub-project friendly
  ([024cc77](http://github.com/abdes/asap/commit/024cc77d17ed134ed5f3f4eea32226b07b05aad6))
- only add clang-format/tidy targets if master project
  ([060f082](http://github.com/abdes/asap/commit/060f082714e039eb4c2c2e198b5caed74690e8af))
- only install files if requested to install
  ([9caaf9b](http://github.com/abdes/asap/commit/9caaf9b47e138be3f9845d6d58ebc21ff8dfa83b))
- reorganize third_party modules for use of FetchContent
  ([cc65bc2](http://github.com/abdes/asap/commit/cc65bc2219dbe38197107bae71252444994e118c))
- use correct tagets for doc builds
  ([559558e](http://github.com/abdes/asap/commit/559558e8eac3043eef19986cc2ae6d6dfd937be8))
- use correct url for logo image
  ([96d1e01](http://github.com/abdes/asap/commit/96d1e01d971bd2f33faaebfc060082023f3a5209))
- use correct url for master index page
  ([a56c327](http://github.com/abdes/asap/commit/a56c327ff3d7ab14d7a499fc4997279efd2647fe))
- use lower case META_PROJECT_ID
  ([311e433](http://github.com/abdes/asap/commit/311e433e8698ff6385c2cda256bff83982596ed0))
- wrong variable used for target name
  ([829f351](http://github.com/abdes/asap/commit/829f351d22b384ddc060ae2df47ff9e801089dd2))

## [4.1.1](http://github.com/abdes/asap/compare/v4.1.0...v4.1.1) (2022-02-18)

- docs: use submodule documentation deployment urls for inter-sphinx
  configuration. using the local build directory will result in the deployed
  documentation to still be dependent on the build paths.

## [4.1.0](http://github.com/abdes/asap/compare/v4.0.2...v4.1.0) (2022-02-18)

- improvements and bug fixes in the documentation
- update GSL to 4.0.0

## [4.0.2](http://github.com/abdes/asap/compare/v4.0.1...v4.0.2) (2022-02-17)

This is a patch update to fix minor issues in the documentation files and to
refactor the docs for easier maintenance and use in forked projects.

### Bug Fixes

- contract api docs now in contract module
  ([d3366bd](http://github.com/abdes/asap/commit/d3366bd846d66486b2fcf98f36fd741452be8516))
- keep `src` even when empty for doxygen not to complain
  ([be28f42](http://github.com/abdes/asap/commit/be28f429eddde8f258a08e84722e4fcaf975b384))

## [4.0.1](http://github.com/abdes/asap/compare/v4.0.1...v4.0.0) (2022-02-17)

- update the GitHub action for windows build to 2022

## [4.0.0](http://github.com/abdes/asap/compare/v3.1.2...v4.0.0) (2022-02-17)

### Features

- overload pattern for variant visitation on the fly
  ([53ea7cc](http://github.com/abdes/asap/commit/53ea7cc74e89913cbf59eda2e30bd36c356e6acd))
- refactor: trim the project to the bare
  minimum([8d48a56](https://github.com/abdes/asap/commit/8d48a56ef0db2359aa80b5e5b2854802dc6a45f0))

  The intention from the asap base project is to be a template starter repo that
  can be cloned and used for new projects. The bare minimum is the cmake build
  infrastructure, documentation, the common submodule and the contract checking
  assertions submodule.

  Contract checking library is now in a separate submodule to keep the common
  module as minimal as possible. Projects that do not intend to use contract
  checking will not have to depend on it.

### Bug Fixes

- use separate sphinx cache dir for each module
  ([03f36fc](http://github.com/abdes/asap/commit/03f36fc96c78c51b441feb9a7b9c70d19a2125c7))

## [3.1.2](http://github.com/abdes/asap/compare/v3.1.1...v3.1.2) (2021-12-19)

### Features

- doxygen snippets from `test` or `examples` source directories
  ([85b8000](http://github.com/abdes/asap/commit/85b8000e91dd105c0f90a62b1824957b68ce9c03))

### Bug Fixes

- **doc:** wrong chapter title in logging module page
  ([5966912](http://github.com/abdes/asap/commit/59669122d3ea8565878667e6f09b124bc7da1b99))
- doxygen doc generation uses wrong module info
  ([8833474](http://github.com/abdes/asap/commit/8833474402c523a3f2eda10b8927da46989f4bba))
- need to hardcode `asap` when linking `common`
  ([e038a70](http://github.com/abdes/asap/commit/e038a702ce8727fa1a6c8b3a45cb4bb211281db5))

## [3.1.1](http://github.com/abdes/asap/compare/v3.1.0...v3.1.1) (2021-12-19)

### Documentation

- minor tweaks to the sphinx config

## [3.1.0](http://github.com/abdes/asap/compare/v3.0.0...v3.1.0) (2021-12-18)

### ⚠ BREAKING CHANGES

- The logging `Registry` is now implemented as a singleton class and therefore
  it needs to be accessed via its instance() method. All other methods in its
  interface are not static anymore.
- Prefix the build options with `ASAP_` to make them unique and avoid clashing
  with other projects that may use the generic `OPTION_xxx` names. Additionally,
  the build presets now always activate building of tests and examples except in
  release builds where examples are not built.
- The cmake option `OPTION_SELF_CONTAINED` is no longer relevant as we believe
  that 3rd party dependencies should be installed using their own projects. In
  the worst case scenario, they should be explicitly added as install
  instructions to the project in a visible and documented way.

### Features

- add support for .editorconfig
  ([5a7a689](http://github.com/abdes/asap/commit/5a7a6892f7c05798e79c6f81e9eef3b0a6256ca1))
- provide a way to distinguish between debug and release builds via preprocessor
  define
  ([bbd84a2](http://github.com/abdes/asap/commit/bbd84a2c32c9833f79b442e202b647f93946b105))

### Bug Fixes

- adjust doc target names to work in renamed projects
  ([60acc65](http://github.com/abdes/asap/commit/60acc65fcc8d529a69f3617d792376be3e54b6ce))
- cmake option was placed in the wrong command
  ([b634b15](http://github.com/abdes/asap/commit/b634b153db975a8bc8715e82f7fafdc214504cfa))
- clean the logging API implementation
  ([25535c7](http://github.com/abdes/asap/commit/25535c76c0586d53f7c6c55db250a251f0c5390b))

## [3.0.0](http://github.com/abdes/asap/compare/v2.0.1...v3.0.0) (2021-12-08)

### ⚠ BREAKING CHANGES

- The project requires C++17 as it is widely available in compilers now. Logical
  traits such as conjunction, disjunction and negation are available from the
  <type_traits> standard include.
- major redesign of the cmake build system, many macros and functions have been
  changed and the build system overall has been simplified.
- `catch2` has been replaced by Google Test/Mock, which provides more features,
  less compiler warnings and is more popular. Catch2 or any other framework can
  still be easily added to an `asap` based project.
- `hedely` was removed from `common` and was replaced by a much lighter new file
  `compilers.h`.
- `nowide` was removed from `common` and will be replaced by the standalone
  boost nowide library when needed.
- `filesystem` footprint is too large to be included by default in `asap`
  starter project. It will be provided separately and a mechanism to easily add
  it into an `asap` based project will be implemented in a future update.

### Features

- add gsl library
  ([9b982f1](http://github.com/abdes/asap/commit/9b982f17aeb9362619cf871ed9bbedb65344ab43))
- add support for CMake presets
  ([bdcfa4d](http://github.com/abdes/asap/commit/bdcfa4d6a0cfffe0026af39b635c6dcd4e61e3a8))
- add contract checking api (assertions)
  ([c691446](http://github.com/abdes/asap/commit/c691446fd18242840e62529f1aabdaf8480b7ec6))
- convert git submodule to local module
  ([4e32e8a](http://github.com/abdes/asap/commit/4e32e8a6d1152413af12c7013ee759eca5e2d51d))
- redesign cmake build system
  ([31ce14a](http://github.com/abdes/asap/commit/31ce14a301ac2e725b7760581e696f089225b161))
- remove filesystem submodule
  ([e2089ae](http://github.com/abdes/asap/commit/e2089ae7707c1448c78db23db2f53cbfab461599))
- remove logical traits backport
  ([5ed0fe6](http://github.com/abdes/asap/commit/5ed0fe6e9e03399e640221a285f87a1a8a015cd1))

- significantly enhance the documentation, both doxygen based for APIs and
  sphinx based for the project docs

### Bug Fixes

- configure compilation database for clangd when using cmake presets
  ([7493c24](http://github.com/abdes/asap/commit/7493c240ce97396040d9a7bd09cb32ed56ea2340))
- hardcode `asap` in places where we should not use the custom project name
  ([7f81298](http://github.com/abdes/asap/commit/7f81298b31e5a235bf4bce4778525a2e4594befa))
- match Clang and Apple Clang for compiler options
  ([7e1e123](http://github.com/abdes/asap/commit/7e1e12317b62099bb58ce5dd4adfdbf1a759ad03))
- convert unit testing to gtest/gmock
  ([b99c8d0](http://github.com/abdes/asap/commit/b99c8d0a315bb8200ca9cec93c9d5f64880c9271))

## [2.0.1](http://github.com/abdes/asap/compare/v2.0.0...v2.0.1) (2021-11-06)

### Bug Fixes

- "-Wreserved-identifier" only if not APPLE
  ([05fac12](http://github.com/abdes/asap/commit/05fac12d37978c6651c299e6ad1cc64dfed88fa0))
- cmake require c++ 14 in all modules
  ([f05c9a6](http://github.com/abdes/asap/commit/f05c9a63e97dbcbef3e7d8188a04e719e2247d62))
- use lower-case name for sphinx
  ([f3005b5](http://github.com/abdes/asap/commit/f3005b5bd4055b16a57cdcb3af70a2f32b1c5809))

## [2.0.0](http://github.com/abdes/asap/compare/v1.0.0...v2.0.0) (2021-11-06)

### Features

- Cleanup the code to remove most compiler and linter warnings.
- Refactor cmake build files to have robust support for sanitizers and linters.
- Rationalize the compiler options to strictly stick to those options that won't
  conflict with application decisions.
- Enhanced the documentation

### To be continued

- Refactoring of cmake build files.
- Remove additional warnings from code.
- Documentation.

### ⚠ BREAKING CHANGES

- logging is in a new module: asap::logging.

Many modules would want to only get the basic common functionality without
pulling extra 3rd party dependencies such as spdlog, fmt etc... For this reason,
the logging functionality is taken out of the common submodule and moved to
logging submodule.

- move logging functionality to separate module
  ([46f4dd9](http://github.com/abdes/asap/commit/46f4dd96edb1148e0772a1539b989fd80f3821e4))

## 1.0.0 (2021-11-03)

### Features

- add support for Conventional Commits and auto Changelog
  ([7b827fa](http://github.com/abdes/asap/commit/7b827fab2ae28ba903c69ab5acdf249cb3e55d85))
- replace cmake compiler detection with hedley
  ([8bf0a3d](http://github.com/abdes/asap/commit/8bf0a3d53fcdba65497491cbd63c1dcffcba8467))
