# os-utils
I created these utilities to make my life easier. Hopefully they do the same for you.

## Symbolic Links
The Windows utilities take advantage of symbolic links. The symbolic links will be created for use in directories where you would like to place the files for use.

Symbolic links can be created with the Link ShellExtension found here [Install Page](https://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html)

Link ShellExtension can also be installed via chocolatey by issuing

`choco install linkshellextension`

from a command prompt. Make sure you have chocolatey installed. The current user must have administrator privileges in order to install the software via choco


## Bash Profile
This file is loaded before Terminal loads your shell environment and contains all the startup configuration and preferences for your command line interface.

Bash Profile changes to `# Variables` are needed to change directories to your folder structure.
