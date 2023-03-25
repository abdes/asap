.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

*******************
Development Process
*******************

.. |date| date::

Last Updated on |date|

Version control
===============

We use Git and we require a recent version of the git tools to take advantage of
enhanced features and avoid unnecessary bugs. It is strongly recommended to use
the latest available version of git on the supported platforms.

Cloning for the first time
--------------------------

.. code-block:: bash

  $ git clone --recurse-submodules https://github.com/abdes/asap.github


Development workflow
====================
We adopt a simplified git-flow workflow, keeping only the develop and master
branches (no release branch), with the following principles:

  * The master branch should be the stable, golden version of the repos
  * The develop branch is the current stable, buildable version of the repos
  * New feature development is done in feature branches

Feature branches
----------------
The workflow for feature branches is similar ot git-flow except that the
git-flow tools are not used.  Instead, either the git commands are used directly
from the command line or via the web interface of github.

Start a new feature
^^^^^^^^^^^^^^^^^^^
.. code-block:: bash

   $ git checkout -b feature/MYFEATURE develop

Finish a feature
^^^^^^^^^^^^^^^^
.. code-block:: bash

   git checkout develop
   git merge --no-ff feature/MYFEATURE
   git branch -d feature/MYFEATURE

.. _fast-forward-label:
.. important::
   Whenever possible, Git normally tries to “fast forward” commits during a
   merge. The decision to FF is based upon whether or not the commit’s ancestry
   in the history doesn’t require a branch in the commit graph. However, in some
   cases it may be preferable to create a dedicated merge commit (effectively
   resulting in a commit graph branch), even though technically-speaking the
   linear commit ancestry does not require it.

   The --no-ff flag forces the creation of such “merge commit”, which thereby
   records the merge as a distinct branch in the commit graph. This can be
   useful for reverting a set of commits (e.g. the entirety of a feature branch,
   or release branch).

   This flag is used by default by git-flow, and by GitHub’s Pull Request
   “merge” button (thus why the “revert” button is available in the GitHub web
   user interface).

Release Process
---------------
A key element of the release approach for the project is that there is NO
release branch.  Instead, the process is:

  * Once the ``develop`` branch has the right set of features and is stable,
  * Changes to ``develop`` are “closed” for the interim,
  * The release process is followed (see table below),
  * Once the release is complete (merged to ``master``, tagged) the ``develop``
    branch is open for work again.

.. list-table::
   :widths: 10 90
   :header-rows: 0

   * - 1
     - git checkout develop

   * - 2
     - git pull
   * - 3
     - git commit -a

   * - 4
     - git push

   * - 5
     - git checkout master

   * - 6
     - git pull

   * - 7
     - Merge into master from the develop branch (no fast-forward => ensure
       there is always a dedicated merge commit)

       .. code-block:: shell

          git merge --no-ff develop

.. tip::
  :class: margin

  This will generate the changelog, update version numbers in `CMakeLists.txt`,
  and create a new tag.

  See `Conventional Commits <https://www.conventionalcommits.org/en/v1.0.0/>`_
  for more information on how conventional commit messages can simplify
  changelog preparation.

.. list-table::
   :widths: 10 90
   :header-rows: 0

   * - 8
     - Release a new version with `standard-version`.

       .. code-block:: shell

         npx standard-version --help

         npx standard-version --dry-run

         npx standard-version --skip.commit --skip.tag

       Check the generated changelog and edit if needed. Verify the updated
       version number is correct.

       Commit the cnhages and push to the remote.

       .. code-block:: shell

          git commit -a -m "version bump to M.m.p"
          git push

       .. note::

          These steps can be automatic with standard-version, but it is
          recommended to not automate them as often the generated changelog
          needs some refinements before it is committed and a release tag is
          made.

.. list-table::
   :widths: 10 90
   :header-rows: 0

   * - 9
     - Create a new tag on the `master` branch with appropriate label and push
       it to the remote.

       .. code-block:: shell

          git tag -a M.m.p -m "release M.m.p"
          git push origin M.m.p

   * - 10
     - Merge master back into develop to include the merge commit (see --no-ff
       notes below)

       .. code-block:: shell

          git checkout develop
          git merge master
          git push

.. note::
   See the :ref:`Feature branches <fast-forward-label>` section above to read
   more about --no-ff.

   Because a separate “merge commit” is created, it is important to merge the
   master branch back into develop as-is, so that master and develop are in
   sync (just as per `git-flow`). In fact, the tag will be associated with the
   merge commit, so it is important to have this tag present in the develop
   branch too.

This process needs to be done carefully to avoid any problems from the
submodules. Always check that the `master` and `develop` branches still have
the same, correct submodule pointer:

.. code-block:: bash

   $ git checkout master
   $ git submodule status
   $ git checkout develop
   $ git submodule status
