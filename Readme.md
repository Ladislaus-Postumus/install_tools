install_tools
======

This is a Powershell-Script which will install tools for you.
The tools are install with the Chocolatey package manager
If a tool is already installed with Choco it will be updated.

The Script will elevate itself to install everything.

Currently included tools:
* Chocolatey
* Firefox
* git
* Neovim
* Gradle
* Groovy
* Python 3 & 2
* uTorrent
* Paint.Net

Commandline Arguments
---------------------

* `less` - will only install Choco and Firefox
* `vim` - swaps Neovim for Vim
* `neovim` - installs neovim despite `less`
* `git` - installs git despite `less`
* `Paint.Net` - installs Paint.Net despite `less`
* `torrent` - installs uTorrent despite `less`

TODO
----

- [ ] install (newest) JDK
- [ ] install different Versions of JRE

For the Oracle version not possible with Choco.

- [ ] get Vim settings from GitHub
- [ ] install Vim Plugins
