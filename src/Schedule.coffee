class window.Schedule
	@runEvery: (x, func, self) ->
		if ticks % x == 0
			func.call(self)

	@runEveryAsync: (x, func, self) ->
		if ticks % x == 0
			setTimeout(->
				func.call(self)
			, 0)
