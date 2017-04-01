# About

This module provides a profiler implementation that allows you to easily
add undo/redo functionality to your applications.

# Dependencies

The Unit Tests for this module rely on Bruce Henderson's **bah.maxunit**
module available from his **maxmods/bah.mod** [GitHub repository][5].

# Installation

To install this module, copy the **profiler.mod** directory into a folder
called **muttley.mod** in your **BlitzMax\mod** directory.

For example, on Windows:

	xcopy profiler.mod C:\BlitzMax\mod\muttley.mod\. /E /I

On Linux:

	mkdir /opt/BlitzMax/mod/muttley.mod
	cp -r profiler.mod /opt/BlitzMax/mod/muttley.mod/.

Then build the module as follows (assuming bmk is in your path):

	bmk makemods -a muttley.profiler

# Unit Tests

Unit Tests for the module are included in the **profiler.mod\UnitTests**
folder, and these can be run as follows:

	bmk makeapp -a -r -t console -x profiler.mod\UnitTests\Main.bmx

# Example

The **profiler.mod\Example** directory contains a small graphical
application that shows how this module can be used.  This can be compiled and
run as follows:

	bmk makeapp -a -r -t gui -x profiler.mod\Example\Main.bmx

#Sublime Project

For [Sublime Text][1] users there is a project file which can be used if you
wish modify this module in any way.  The project file includes build systems
for building the module, and building and running both the Unit Tests and
Example application.  These build systems rely on the [Gradle][2] build
automation system.

#License

Copyright (c) 2009-2013 Paul Maskelyne ([muttley@muttleyville.org][3]).

All rights reserved. Use of this code is allowed under the Artistic License
2.0 terms, as specified in the LICENSE file distributed with this code, or
available from [http://www.opensource.org/licenses/artistic-license-2.0.php][4]

[1]: http://www.sublimetext.com/
[2]: http://www.gradle.org/
[3]: mailto:muttley@muttleyville.org
[4]: http://www.opensource.org/licenses/artistic-license-2.0.php
[5]: https://github.com/maxmods/bah.mod
