MomsFriendlyDevCo Init Scripts
==============================
A collection of setup scripts to deploy a Linux server.


Quick start guide
-----------------
Clone the repo and run one of the `ROLE-*` scripts to setup a server matching that profile.

For example if you want a Node web server run:

	# Make sure Git is installed
	sudo apt-get install -y git

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

* Use `echoStatus <text>` or `echoSkip <text>` as a reporting mechanism instead of plain `echo`
* Require little to no interaction past the initial execution
