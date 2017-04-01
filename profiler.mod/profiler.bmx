Rem
'
' Copyright (c) 2007-2017 Paul Maskelyne <muttley@muttleyville.org>.

' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
EndRem

SuperStrict

Rem
    bbdoc:muttley\profiler
End Rem
Module muttley.profiler

ModuleInfo "Version: 1.0.0"
ModuleInfo "License: Artistic License 2.0"
ModuleInfo "Author: Paul Maskelyne (Muttley)"
ModuleInfo "Copyright: (c) 2007 Paul Maskelyne"
ModuleInfo "E-Mail: muttley@muttleyville.org"
ModuleInfo "Website: http://www.muttleyville.org"

ModuleInfo "History: 1.0.0"
ModuleInfo "History: Initial Release"

Import brl.linkedlist
Import brl.map
Import brl.retro
Import brl.stream

Include "Source\TProfiler.bmx"
Include "Source\TProfilerResult.bmx"
Include "Source\TProfilerSample.bmx"
