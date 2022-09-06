MomsFriendlyDevCo Init Scripts
==============================
A collection of setup scripts to deploy a Linux environment.


Quick start guide
-----------------
Clone the repo and run one of the `ROLE-*` scripts to setup a server matching that profile.

For example if you want a Node web server run:

	# Make sure Git is installed
	sudo apt install -y git

	# Clone everything
	git clone https://github.com/MomsFriendlyDevCo/Init.git
	cd Init

	# Install the required ROLE
	./ROLE-server-node


Cherry-picking guide
--------------------
Each script is designed to be run as a non-root user (escapting to sudo when needed).

These scripts follow the sequence '<run order>-<item>' where the number dictates the order they should be run.

You can queue up multiple scripts on the command line, picking the items you require.

For example to install NodeJS, Python and Ruby you could run:

	./020-node && ./020-python && ./020-ruby


Rules
=====
Each action script (i.e. any script matching `???-*`) must follow the following:

Each script _must_:

* Include a Bash hashbang (i.e. `#!/bin/bash`) as the first line and be executable
* Include documentation in the header
* Import the common library via `source common` somewhere in its header
* Fail gracefully and not stop application flow unless a critical failure has occured
* Be runnable multiple times - this is to support future upgrades. A script must be capable of being run again at some future date with no side effects


Each script _should_:

* Use `init status <text>` or `init skip <text>` as a reporting mechanism instead of plain `echo`
* Require little to no interaction past the initial execution


General Syntax
==============
This package comes complete with various helper functions which are all called with the `init` syntax.

| Category            | Command                                | Description                                                               |
|---------------------|----------------------------------------|---------------------------------------------------------------------------|
| Status              | `init status <message>`                | Display a status message                                                  |
|                     | `init skip <message>`                  | Same as `init status` but display that the operation was skipped          |
| Installs + Packages | `init apt-install <pkgs...>`           | Install Apt packages                                                      |
|                     | `init pip-install <pkgs...>`           | Install various Python3 + Pip packages                                    |
|                     | `init rust-install <pkgs...>`          | Install various Rust / Cargo packages                                     |
|                     | `init source-clone <alias> <git-url>`  | Clone / update a Git-Url into `~/src/$ALIAS` and change to that directory |
| System querying     | `init bin-available <bin>`             | Return `1` if a Binary is available and within the PATH                   |
|                     | `init file-grep-matches <file> <grep>` | Return `1` if the given file path contains the given Grep expression      |
