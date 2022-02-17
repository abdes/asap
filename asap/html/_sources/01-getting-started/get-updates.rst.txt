.. Structure conventions
     # with overline, for parts
     * with overline, for chapters
     = for sections
     - for subsections
     ^ for sub-subsections
     " for paragraphs

.. _get-updates:

***********
Get updates
***********

.. |date| date::

Last Updated on |date|

If you have properly followed the instructions when :ref:`get-the-code`, you
should have a fork setup with the original `asap` as its upstream, thus allowing
you to sync updates that may have been made in `asap` after you forked it.

Syncing your fork to keep it up-to-date with the upstream repository can be done
from the Github web UI or from the command line. Both methods are described in
detail at the GitHub `Syncing a fork
<https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork>`_
documentation page.

The following steps provide a summary of the command line method, assuming that
the branch being worked on in your forked project is the `develop` branch.

.. prompt:: bash $ auto

  $ git fetch upstream
  remote: Enumerating objects: 5, done.
  remote: Counting objects: 100% (5/5), done.
  remote: Compressing objects: 100% (1/1), done.
  remote: Total 3 (delta 2), reused 3 (delta 2), pack-reused 0
  Unpacking objects: 100% (3/3), 361 bytes | 6.00 KiB/s, done.
  From https://github.com/abdes/asap
    3d8ca08..a085b56  develop    -> upstream/develop

.. prompt:: bash $ auto

  $ git checkout develop
  Switched to branch 'main'

.. prompt:: bash $ auto

  $ git merge upstream/master
  Updating 3d8ca08..a085b56
  Fast-forward
    CMakePresets.json | 14 ++++++++++++--
    1 file changed, 12 insertions(+), 2 deletions(-)

.. tip::

  The example uses `upstream/master` as the branch with which the fork is kept
  in sync. You may want to use `upstream/develop` if you want to live on the
  cutting edge of `asap` features.
