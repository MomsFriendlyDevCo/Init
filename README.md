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
* Import the common library via `source common` somewhere in its header (NOTE: any script in `./utils/` needs to use `[ -z "$INIT_READY" ] && source common` as the current directory may not be the same as `$INIT_HOME`
* Fail gracefully and not stop application flow unless a critical failure has occured
* Be runnable multiple times - this is to support future upgrades. A script must be capable of being run again at some future date with no side effects


Each script _should_:

* Use `INIT status <text>` or `INIT skip <text>` as a reporting mechanism instead of plain `echo`
* Require little to no interaction past the initial execution


General Syntax
==============
This package comes complete with various helper functions which are all called with the `init` syntax.

All commans in this set `exit 0` (i.e. no failures). Any that returns a boolean will either return the string `0` or `1` and should be queried in Bash with equality:

```bash
if [ `INIT apt-has foo bar baz` == 1 ]; then
	echo "Foo, Bar + Baz are all installed"
else
	echo "Foo, Bar + Baz are all missing!"
fi
```


|-------------------|----------------------------------------|--------|----------------------------------------------------------------------------------------------------|
| Category          | Command                                | Flags? | Description                                                                                        |
|-------------------|----------------------------------------|--------|----------------------------------------------------------------------------------------------------|
| Status Output     | `INIT skip <message>`                  |        | Same as `INIT status` but display that the operation was skipped                                   |
|                   | `INIT status <message>`                |        | Display a status message                                                                           |
| Change directory  | `INIT go-init`                         |        | Change back to the base Init directory, should be called last on any script which changes anything |
|                   | `INIT go-src [sub-dir]`                |        | Change to the $INIT_SRC directory (+ optional sub-dir), creating it/them if they dont exist        |
| Misc              | `INIT noop`                            |        | Do nothing, intends to make if-then-else blocks more readable - like Pythons 'pass'                |
| Packages / Apt    | `INIT apt-has <pkgs...>`               |        | Query if all packages are installed                                                                |
|                   | `INIT apt-install <pkgs...>`           | Yes    | Install Apt packages                                                                               |
|                   | `INIT apt-install-url <URLs...>`       |        | Download .DEB packages from the given URLs and install them                                        |
|                   | `INIT apt-remove <pkgs...>`            | Yes    | Remove all specified packages                                                                      |
| Packages / Cargo  | `INIT cargo-install <pkgs...>`         |        | Install various Rust / Cargo packages                                                              |
| Packages / NPM    | `INIT npm-install <pkgs...>`           |        | Install various Node / NPM packages                                                                |
| Packages / Pip    | `INIT pip-install <pkgs...>`           |        | Install various Python3 + Pip packages                                                             |
| Packages / Pip    | `INIT snap-install <pkgs...>`          |        | Install various Snap packages                                                                      |
| Packages / Source | `INIT bin-download-run <url>`          |        | Download a binary URL and run the results                                                          |
|                   | `INIT file-download-url <urls..>`      | Yes    | Download one or more URLs into the current directory                                               |
|                   | `INIT source-clone <alias> <git-url>`  |        | Clone / update a Git-Url into `~/src/$ALIAS` and change to that directory                          |
| Files             | `INIT file-grep-matches <file> <grep>` |        | Return `1` if the given file path contains the given Grep expression                               |
|                   | `INIT file-set <file> <<HEREDOC`       | Yes    | Output contents of HEREDOC into a file                                                             |
| System querying   | `INIT bin-available <bins...>`         |        | Return `1` if a all listed Binaries are available and within the PATH                              |
|                   | `INIT bin-grep-matches <cmd> <grep>`   |        | Run a program and return `1` if it matches the specified grep expresison                           |
|                   | `INIT service-available <service>`     |        | Return `1` if the given service is available (even if disabled)                                    |
|                   | `INIT tmux-connect <session>`          |        | Connect to an existing TMUX session by name - or create it if missing                              |
| Init core         | `INIT run <unit>`                      |        | Run one internal Init setup script                                                                 |
|-------------------|----------------------------------------|--------|----------------------------------------------------------------------------------------------------|
