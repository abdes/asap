.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for subsubsections
     " for paragraphs

*******************
Development Process
*******************

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

.. list-table:: Frozen Delights!
   :widths: 5 30 30
   :header-rows: 0

   * - 1
     - git checkout develop
     -
   * - 2
     - git pull
     - make sure we’ve got the latest code
   * - 3
     - git commit -a
     - make sure we don’t have any pending changes
   * - 4
     - git push
     - make sure the server is up to date too
   * - 5
     - git checkout master
     - make sure we don’t have any pending changes
   * - 6
     - git pull
     - make sure we’ve got the latest code
   * - 7
     - git merge --no-ff develop
     - Merge into master from the develop branch (no fast-forward => ensure
       there is always a dedicated merge commit)
   * - 8
     - .. todo:: update version numbers
       .. todo:: update build badges in README.md to use master branch
     - See `semantic versioning <https://semver.org>`_
   * - 9
     - git commit -a -m "version bump to M.m.p"
     -
   * - 10
     - git push
     -
   * - 11
     - git tag -a M.m.p -m "release M.m.p"
     - Tag `master` with appropriate label.
       See `here <https://git-scm.com/book/en/v2/Git-Basics-Tagging>`_
   * - 12
     - git push origin M.m.p
     - Pushes the tag to the remote repository
   * - 13
     - git checkout develop
     - Once all master branches are done, only then back-merge into develop
   * - 14
     - git merge master
     - Merge master back into develop to include the merge commit
       (see --no-ff notes below)
   * - 15
     - .. todo:: version bump for develop
       .. todo:: update build badges in README.md to use develop branch
     - Version bump (e.g. from 0.9.0 to 0.9.1,
       see `semantic versioning <https://semver.org>`_)
   * - 16
     - git commit -a -m "version bump to M.m.p"
     -
   * - 17
     - git push
     -

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
