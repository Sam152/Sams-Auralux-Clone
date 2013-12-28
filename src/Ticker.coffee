###
Define a way to execute funcitons consistently at a specific framerate.
###
class window.Ticker
	
	constructor: (settings) ->
		
		@settings = _.extend({
			ticks_per_second : 30,
			tick_function : () ->
		}, settings)

		@target_tick_time = (1000 / @settings.ticks_per_second)
		@stopped = true
		@count = 0

	###
	Start a ticker at the desired speed.
	###
	start: () ->
		
		@stopped = false
		self = @
		next_tick_ms = 0

		execute_tick = () ->
			setTimeout(
				() ->
					@count++
					# Execute the timed tick function.
					start = self.milliseconds()
					self.settings.tick_function()
					end = self.milliseconds()

					# Find out how long the current tick took
					tick_time = end - start
					next_tick_ms = if tick_time > self.target_tick_time then 0 else self.target_tick_time - tick_time

					# Spam the console with some perf warnings.
					if tick_time > self.target_tick_time
						console.log('Ticker hitting performance limit.')

					# If we have permission to continue, do so.
					if !self.stopped
						execute_tick()
				# Start the next tick when the difference between the last tick
				# time and the framerate has elapsed.
				next_tick_ms
			)

		execute_tick()

	milliseconds: () ->
		return Date.now()

	stop: () ->
		@stopped = true

	getTickCount: () ->
		return @settings.count

