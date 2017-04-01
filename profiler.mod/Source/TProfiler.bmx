Rem
'
' Copyright (c) 2007-2017 Paul Maskelyne <muttley@muttleyville.org>.
'
' All rights reserved. Use of this code is allowed under the
' Artistic License 2.0 terms, as specified in the LICENSE file
' distributed with this code, or available from
' http://www.opensource.org/licenses/artistic-license-2.0.php
'
EndRem

Rem
'
' This code is based on teamonkey's Inline Profiler for BlitzMax v0.1
' Copyright (c) 2005 James Arthur <teamonkey@gmail.com>
'
EndRem

Rem
	bbdoc: profiler management class
EndRem
Type TProfiler

	Const DEFAULT_PROFILER_ENABLED:Int  = False
	Const DEFAULT_PROFILER_FILENAME:String = "profiler.txt"

	Global _instance:TProfiler

	Field _enabled:Int      = DEFAULT_PROFILER_ENABLED
	Field _filename:String  = DEFAULT_PROFILER_FILENAME
	Field _resultList:TList = CreateList()
	Field _sampleList:TList = CreateList()

	Rem
		bbdoc: Get the instance of the profiler
		returns: A Singleton instance of TProfiler
		about: The profiler is a singleton class and this function should be
		used to access it
	EndRem
	Function GetInstance:TProfiler()
		If Not _instance
			Return New TProfiler
		Else
			Return _instance
		EndIf
	EndFunction

	Method _MaxSampleDepth:Int()
		Local maxDepth:Int = 0
		For Local i:TProfilerSample = EachIn _sampleList
			If i.level > maxDepth Then maxDepth = i.level
		Next
		Return maxDepth
	EndMethod

	Method _WriteResultsToFile()
		If Not _enabled Then Return

		Local file:TStream = WriteStream (_filename)

		file.WriteLine ("              Profile Name              | min/msec | max/msec | avg/msec | calls ")
		file.WriteLine ("----------------------------------------+----------+----------+----------+-------")

		For Local result:TProfilerResult = EachIn _resultList
			If result.run_count > 0
				Local str:String
				str = LSet (RSet (result.name, result.name.length + result.level), 39)
				str :+ " | "
				str :+ RSet (Left (String.FromDouble (result.min_t), 8), 8)
				str :+ " | "
				str :+ RSet (Left (String.FromDouble (result.max_t), 8), 8)
				str :+ " | "
				str :+ RSet (Left (String.FromDouble (result.avg_t), 8), 8)
				str :+ " | "
				str :+ result.run_count

				file.WriteLine (str)
			EndIf
		Next

		file.Close()
	EndMethod

	Rem
		bbdoc: Calculates the results of the profiler
		about: Once the results have been calculated, they are written out to
		a file
	EndRem
	Method CalculateResults()
		If Not _enabled Then Return

		ClearList (_resultList)

		' Put all the results in a list, with child samples associated with
		' their parent
		Local depth:Int = 0
		While depth <= _MaxSampleDepth()
			For Local sample:TProfilerSample = EachIn _sampleList

				If sample.level = depth
					Local result:TProfilerResult = New TProfilerResult
					result.FromSample (sample)

					If depth = 0
						' Just shove level 0 objects in the list, no need
						' to do anything else
						If result.level = 0
							result.link = ListAddLast (_resultList, result)
						 EndIf
					Else
						' Insert the results in the list after their respective
						' parents
						If result.level = depth
							For Local i:TProfilerResult = EachIn _resultList
								If result.parent_name = i.name
									result.link = _resultList.InsertAfterLink (result, i.link)
								EndIf
							Next
						EndIf
					EndIf
				EndIf
			Next
			depth:+1
		Wend

		_WriteResultsToFile()
	EndMethod

	Rem
		bbdoc: Get the instance of the registry
		returns: The Singleton instance TRegistry
		about: The registry is a singleton class and this function should be used
		to access it
	EndRem
	Method CreateSample:TProfilerSample (name_in:String)
		Local newSample:TProfilerSample = New TProfilerSample
		newSample.name = name_in
		newSample.link = ListAddLast (_sampleList, newSample)
		Return newSample
	EndMethod

	Rem
		bbdoc: Disables the profiler
	EndRem
	Method Disable()
		_enabled = False
	EndMethod

	Rem
		bbdoc: Enables the profiler
	EndRem
	Method Enable()
		_enabled = True
	EndMethod

	Rem
		bbdoc: Default constructor
	EndRem
	Method New()
		If _instance Throw "Cannot create multiple instances of Singleton Type"
		_instance = Self
	EndMethod

	Rem
		bbdoc: Resets the profiler
	EndRem
	Method ResetProfiler()
		ClearList (_sampleList)
	EndMethod

	Method ToString:String()
		Return "Profiler"
	EndMethod

EndType

Rem
	bbdoc: Create a new profiler sample
	returns: TProfilerSampler
	about: Helper function for creating new profiler samples
EndRem
Function CreateProfilerSample:TProfilerSample (name:String)
	Return TProfiler.GetInstance().CreateSample (name)
EndFunction

Rem
	bbdoc: Delete a profiler sample
	returns: TProfilerSampler
	about: Helper function for creating new profiler samples
EndRem
Function DeleteProfilerSample (sample:TProfilerSample)
	TProfilerSample.DeleteSample (sample)
EndFunction

Rem
	bbdoc: Disabled the profiler
EndRem
Function DisableProfiler()
	TProfiler.GetInstance().Disable()
EndFunction

Rem
	bbdoc: Enables the profiler
EndRem
Function EnableProfiler()
	TProfiler.GetInstance().Enable()
EndFunction

Rem
	bbdoc: Starts a Profiler Sample
	about: This should be called before the code you are sampling begins
EndRem
Function StartProfilerSample (sample:TProfilerSample)
	sample.Start()
EndFunction

Rem
	bbdoc: Stops a Profiler Sample
	about: This should be called after the code you are sampling completes.
	If no sample object is provided then it will stop the sample which was
	started last.
EndRem
Function StopProfilerSample (sample:TProfilerSample = Null)
	If (Not sample) Then sample = TProfilerSample.last_sample
	sample.Stop()
EndFunction
