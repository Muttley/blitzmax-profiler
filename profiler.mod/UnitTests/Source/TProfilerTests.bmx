Type TProfilerTests Extends TTest

	Field _profiler:TProfiler

	Method Setup() {before}
		_profiler = TProfiler.GetInstance()
	EndMethod

	Method CanInstantiateProfiler() {test}
		AssertNotNull (_profiler)
	End Method

	Method CannotInstantiateMoreThanOneProfiler() {test}
		AssertNotNull (_profiler)

		local exceptionRaised:Int = False
		Try
			local badProfiler:TProfiler = New TProfiler
		Catch ex:Object
			exceptionRaised = True
		EndTry

		assertTrue (exceptionRaised)
	End Method

EndType
