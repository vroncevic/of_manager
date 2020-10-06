# Office management

**of_manager** is shell tool for controlling/operating Open Office.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![of_manager shell checker](https://github.com/vroncevic/of_manager/workflows/of_manager%20shell%20checker/badge.svg)](https://github.com/vroncevic/of_manager/actions?query=workflow%3A%22of_manager+shell+checker%22)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/of_manager.svg)](https://github.com/vroncevic/of_manager/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/of_manager.svg)](https://github.com/vroncevic/of_manager/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

Navigate to release **[page](https://github.com/vroncevic/of_manager/releases)** download and extract release archive.

To install **of_manager** type the following:

```
tar xvzf of_manager-x.y.z.tar.gz
cd of_manager-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/of_manager/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/of_manager/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/of_manager/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/of_manager/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

[![of_manager docker checker](https://github.com/vroncevic/of_manager/workflows/of_manager%20docker%20checker/badge.svg)](https://github.com/vroncevic/of_manager/actions?query=workflow%3A%22of_manager+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/of_manager/ver.1.0/bin/of_manager.sh /root/bin/of_manager

# Setting PATH
export PATH=${PATH}:/root/bin/

# Control/operating Open Office
of_manager version
```

### Dependencies

**of_manager** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**of_manager** is based on MOP.

Code structure:
```
.
├── bin/
│   ├── of_manager.sh
│   └── of_operation.sh
├── conf/
│   ├── of_manager.cfg
│   └── of_manager_util.cfg
└── log/
    └── of_manager.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/of_manager/badge/?version=latest)](https://of_manager.readthedocs.io/projects/of_manager/en/latest/?badge=latest)

More documentation and info at:
* [https://of_manager.readthedocs.io/en/latest/](https://of_manager.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2015 by [vroncevic.github.io/of_manager](https://vroncevic.github.io/of_manager)

**of_manager** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

