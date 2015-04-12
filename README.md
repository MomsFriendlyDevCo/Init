MomsFriendlyDevCo Init Scripts
==============================
A collection of server setup scripts to deploy a server quickly.



Quick start guide
-----------------
Run one of the `ROLE-*` scripts to setup a server matching that profile.

For example if you want a Node web server run:

	./ROLE-server-node


Cherry-picking guide
--------------------
Each script is designed to be run as a non-root user (escapting to sudo when needed).

These scripts follow the sequence '<run order>-<item>' where the number dictates the order they should be run.

You can queue up multiple scripts on the command line, picking the items you require.

For example to install NodeJS, Python and Ruby you could run:

	./020-node && ./020-python && ./020-ruby
