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


Type TProfilerSample
	Global global_level:Int ' Depth of nested profiling
	Global last_sample:TProfilerSample ' Last sample we have started

	Field _firstSample:Int
	Field _max_t:Double
	Field _min_t:Double
	Field end_t:Double
	Field level:Int
	Field link:TLink
	Field name:String
	Field parent:TProfilerSample
	Field run_count:Int
	Field running:Int
	Field start_t:Double
	Field total_t:Double

	Method New()
		running = False
		_firstSample = True
		total_t = 0.0
		run_count = 0.0
	End Method

	Function DeleteSample(sample:TProfilerSample)
		Assert(sample)

		RemoveLink(sample.link)
	End Function


	Method Start()
		If (running) Then Return

		running = True
		level = global_level

		parent = last_sample
		last_sample = Self

	    global_level:+1
		start_t = Millisecs()
		run_count :+ 1
	End Method


	Method Stop()
		If (Not running) Then Return

		last_sample = parent

		running = False

		global_level:-1

		end_t = Millisecs()

		Local sample_t:Double = (end_t - start_t)

		If _firstSample
			_firstSample = False
			_max_t = sample_t
			_min_t = sample_t
		End If

		If sample_t < _min_t Then _min_t = sample_t
		If sample_t > _max_t Then _max_t = sample_t

		total_t:+sample_t

	End Method


	Method get_t:Double()
		Local t:Double = total_t
		total_t = 0.0
		run_count = 0.0
		Return t
	End Method

End Type
