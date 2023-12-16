<img align="right" src="https://raw.githubusercontent.com/vroncevic/of_manager/dev/docs/of_manager_logo.png" width="25%">

# Office management

**of_manager** is shell tool for controlling/operating Open Office.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![of_manager_shell_checker](https://github.com/vroncevic/of_manager/actions/workflows/of_manager_shell_checker.yml/badge.svg)](https://github.com/vroncevic/of_manager/actions/workflows/of_manager_shell_checker.yml)

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

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/of_manager/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/of_manager/releases)** download and extract release archive.

To install **of_manager** type the following

```
tar xvzf of_manager-x.y.tar.gz
cd of_manager-x.y
cp -R ~/sh_tool/bin/   /root/scripts/of_manager/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/of_manager/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/of_manager/ver.x.y/
```

Self generated setup script and execution
```
./of_manager_setup.sh

[setup] installing App/Tool/Script of_manager
	Sun 28 Nov 2021 08:30:35 AM CET
[setup] clean up App/Tool/Script structure
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/of_manager/ver.2.0/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   ├── of_manager.sh
│   └── of_operation.sh
├── conf/
│   ├── of_manager.cfg
│   ├── of_manager.logo
│   └── of_manager_util.cfg
└── log/
    └── of_manager.log

3 directories, 8 files
lrwxrwxrwx 1 root root 50 Nov 28 08:30 /root/bin/of_manager -> /root/scripts/of_manager/ver.2.0/bin/of_manager.sh
```

Or You can use docker to create image/container.

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/of_manager/ver.x.y/bin/of_manager.sh /root/bin/of_manager

# Setting PATH
export PATH=${PATH}:/root/bin/

# Control/operating Open Office
of_manager 

of_manager ver.2.0
Sun 28 Nov 2021 08:47:29 AM CET

[check_root] Check permission for current session? [ok]
[check_root] Done

                                                                                          
              ████                                                                        
             ░██░                                                  █████                  
    ██████  ██████       ██████████   ██████   ███████   ██████   ██░░░██  █████  ██████  
   ██░░░░██░░░██░       ░░██░░██░░██ ░░░░░░██ ░░██░░░██ ░░░░░░██ ░██  ░██ ██░░░██░░██░░█  
  ░██   ░██  ░██         ░██ ░██ ░██  ███████  ░██  ░██  ███████ ░░██████░███████ ░██ ░   
  ░██   ░██  ░██         ░██ ░██ ░██ ██░░░░██  ░██  ░██ ██░░░░██  ░░░░░██░██░░░░  ░██     
  ░░██████   ░██   █████ ███ ░██ ░██░░████████ ███  ░██░░████████  █████ ░░██████░███     
   ░░░░░░    ░░   ░░░░░ ░░░  ░░  ░░  ░░░░░░░░ ░░░   ░░  ░░░░░░░░  ░░░░░   ░░░░░░ ░░░      
                                                                                          
                                                                                          
	                                                         
		Info   github.io/op_manager ver.2.0 
		Issue  github.io/issue
		Author vroncevic.github.io

  [Usage] of_manager [OPTIONS]
  [OPTIONS]
  [OPERATION] start | stop | restart | status | version
  # Start OpenOffice service
  of_manager start
  [help | h] print this option
```

### Dependencies

**of_manager** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**of_manager** is based on MOP.

Shell tool structure
```
sh_tool/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   ├── of_manager.sh
│   └── of_operation.sh
├── conf/
│   ├── of_manager.cfg
│   ├── of_manager.logo
│   └── of_manager_util.cfg
└── log/
    └── of_manager.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/of_manager/badge/?version=latest)](https://of-manager.readthedocs.io/projects/of_manager/en/latest/?badge=latest)

More documentation and info at
* [https://of_manager.readthedocs.io/en/latest/](https://of-manager.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 - 2024 by [vroncevic.github.io/of_manager](https://vroncevic.github.io/of_manager)

**of_manager** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/of_manager/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
