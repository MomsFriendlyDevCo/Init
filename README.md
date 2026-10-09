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

Alternatively, the `setup` script can be piped directly from GitHub to clone the repo into `~/Init` and launch a setup wizard:

	curl -L https://raw.githubusercontent.com/MomsFriendlyDevCo/Init/master/setup | sudo bash

Available roles: `ROLE-desktop-xfce`, `ROLE-server-generic`, `ROLE-server-node`, `ROLE-server-php`, `ROLE-update-desktop`, `ROLE-update-server`.

Defaults for interactive prompts (hostname, timezone etc.) can be preset in the `profile` file.


Cherry-picking guide
--------------------
Each script is designed to be run as a non-root user (escaping to sudo when needed).

These scripts follow the sequence '<run order>-<item>' where the number dictates the order they should be run.

You can queue up multiple scripts on the command line, picking the items you require.

For example to install NodeJS, Python and Rust you could run:

	./020-node && ./020-python && ./200-rust


Rules
=====
Each action script (i.e. any script matching `???-*`) must follow the following:

Each script _must_:

* Include a Bash hashbang (i.e. `#!/bin/bash`) as the first line and be executable
* Include documentation in the header
* Import the common library via `source "$(dirname "${BASH_SOURCE[0]}")/./common"` somewhere in its header (NOTE: any script in `./utils/` needs to use `source "$(dirname "${BASH_SOURCE[0]}")/../common"` instead, as the current directory may not be `$INIT_HOME`). `common` itself skips reinitialisation if `INIT` is already defined in the shell.
* Fail gracefully and not stop application flow unless a critical failure has occurred
* Be runnable multiple times - this is to support future upgrades. A script must be capable of being run again at some future date with no side effects


Each script _should_:

* Use `INIT status <text>` or `INIT skip <text>` as a reporting mechanism instead of plain `echo`
* Require little to no interaction past the initial execution


General Syntax
==============
This package comes complete with various helper functions which are all called with the `INIT` syntax.

All commands in this set `exit 0` (i.e. no failures), with the exception of `INIT panic`. Any that returns a boolean will either return the string `0` or `1` and should be queried in Bash with equality:

```bash
if [ `INIT apt-has foo bar baz` == 1 ]; then
	echo "Foo, Bar + Baz are all installed"
else
	echo "Foo, Bar + Baz are all missing!"
fi
```


|-------------------|------------------------------------------------|--------|----------------------------------------------------------------------------------------------------|
| Category          | Command                                        | Flags? | Description                                                                                        |
|-------------------|------------------------------------------------|--------|----------------------------------------------------------------------------------------------------|
| User input        | `INIT ask -p <message> -v <var> -d <default>`  | Yes    | Prompt the user for various inputs using the `profile` file for defaults (`-b` for yes/no as 1/0)  |
| Status Output     | `INIT fixme <message>`                         |        | Mark that a script needs attention on the next clean system install                                |
|                   | `INIT skip <message>`                          |        | Same as `INIT status` but display that the operation was skipped                                   |
|                   | `INIT status <message>`                        |        | Display a status message                                                                           |
| Change directory  | `INIT go-init`                                 |        | Change back to the base Init directory, should be called last on any script which changes anything |
|                   | `INIT go-src [sub-dir]`                        |        | Change to the $INIT_SRC directory (+ optional sub-dir), creating it/them if they dont exist        |
| Config            | `INIT config-set <file> <key> <val>`           |        | Set an INI file setting, creating it if not already present                                        |
| Misc              | `INIT noop`                                    |        | Do nothing, intends to make if-then-else blocks more readable - like Pythons 'pass'                |
|                   | `INIT panic <message>`                         |        | Display an error message and exit the install process                                              |
|                   | `INIT tolerate <cmd...>`                       |        | Run a command, ignoring any errors it throws                                                       |
| Packages / Apt    | `INIT apt-has <pkgs...>`                       |        | Query if all packages are installed                                                                |
|                   | `INIT apt-install <pkgs...>`                   | Yes    | Install Apt packages                                                                               |
|                   | `INIT apt-install-github-release <owner/repo>` | Yes    | Download + install the latest version of a .DEB packages from a GitHub Repo                        |
|                   | `INIT apt-install-url <URLs...>`               |        | Download .DEB packages from the given URLs and install them                                        |
|                   | `INIT apt-repo-install <name> <key-url> <repo>`| Yes    | Install a third-party APT repo + signing key into `/etc/apt/keyrings` using `signed-by`            |
|                   | `INIT apt-remove <pkgs...>`                    | Yes    | Remove all specified packages                                                                      |
|                   | `INIT apt-update`                              |        | Force update apt, even if its not required                                                         |
| Packages / Cargo  | `INIT cargo-install <pkgs...>`                 | Yes    | Install various Rust / Cargo packages                                                              |
| Packages / NPM    | `INIT npm-install <pkgs...>`                   |        | Install various Node / NPM packages                                                                |
| Packages / Pip    | `INIT pip-install <pkgs...>`                   |        | Install various Python3 + Pip packages                                                             |
| Packages / Snap   | `INIT snap-install <pkgs...>`                  |        | Install various Snap packages                                                                      |
| Packages / Source | `INIT bin-download-run <url> [args...]`        |        | Download a binary URL and run it with optional arguments                                           |
|                   | `INIT file-download-url <urls..>`              | Yes    | Download one or more URLs into the current directory                                               |
|                   | `INIT source-clone <alias> <git-url>`          |        | Clone / update a Git-Url into `~/src/$ALIAS` (use `INIT go-src <alias>` to change to it)           |
| Files             | `INIT file-grep-matches <file> <grep>`         |        | Return `1` if the given file path contains the given Grep expression                               |
|                   | `INIT file-set <file> <<HEREDOC`               | Yes    | Output contents of HEREDOC into a file                                                             |
| System querying   | `INIT bin-available <bins...>`                 |        | Return `1` if a all listed Binaries are available and within the PATH                              |
|                   | `INIT bin-grep-matches <cmd> <grep>`           |        | Run a program and return `1` if it matches the specified grep expression                           |
|                   | `INIT service-available <service>`             |        | Return `1` if the given service is available (even if disabled)                                    |
|                   | `INIT tmux-connect <session> [cmd]`            |        | Connect to an existing TMUX session by name - or create it (optionally running a command)          |
|                   | `INIT tmux-wrap`                               |        | Re-run the current script inside a TMUX session if `INIT_AUTO_TMUX` is non-zero                    |
| Init core         | `INIT run <units...>`                          |        | Run one or more internal Init setup scripts                                                        |
|-------------------|------------------------------------------------|--------|----------------------------------------------------------------------------------------------------|
