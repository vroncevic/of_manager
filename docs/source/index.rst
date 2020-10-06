of_manager
-----------

**of_manager** is shell tool for controlling/operating Open Office.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

|GitHub shell checker|

.. |GitHub shell checker| image:: https://github.com/vroncevic/of_manager/workflows/of_manager%20shell%20checker/badge.svg
   :target: https://github.com/vroncevic/of_manager/actions?query=workflow%3A%22of_manager+shell+checker%22

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/of_manager.svg
   :target: https://github.com/vroncevic/of_manager/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/of_manager.svg
   :target: https://github.com/vroncevic/of_manager/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/of_manager/badge/?version=latest
   :target: https://of_manager.readthedocs.io/projects/of_manager/en/latest/?badge=latest

.. toctree::
    :hidden:

    self

Installation
-------------

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/of_manager/releases

To install **of_manager** type the following:

.. code-block:: bash

   tar xvzf of_manager-x.y.z.tar.gz
   cd of_manager-x.y.z
   cp -R ~/sh_tool/bin/   /root/scripts/of_manager/ver.1.0/
   cp -R ~/sh_tool/conf/  /root/scripts/of_manager/ver.1.0/
   cp -R ~/sh_tool/log/   /root/scripts/of_manager/ver.1.0/

Or You can use Docker to create image/container.

|GitHub docker checker|

.. |GitHub docker checker| image:: https://github.com/vroncevic/of_manager/workflows/of_manager%20docker%20checker/badge.svg
   :target: https://github.com/vroncevic/of_manager/actions?query=workflow%3A%22of_manager+docker+checker%22

Dependencies
-------------

**of_manager** requires next modules and libraries:
    sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

Shell tool structure
---------------------

**of_manager** is based on MOP.

Code structure:

.. code-block:: bash

   .
   ├── bin/
   │   ├── of_manager.sh
   │   └── of_operation.sh
   ├── conf/
   │   ├── of_manager.cfg
   │   └── of_manager_util.cfg
   └── log/
       └── of_manager.log

Copyright and licence
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2015 by `vroncevic.github.io/of_manager <https://vroncevic.github.io/of_manager>`_

**of_manager** is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

