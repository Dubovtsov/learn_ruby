module Debugger
	def message_debugger
		puts "!!! ИНФОРМАЦИЯ ДЛЯ ОТЛАДКИ !!!"
	end

	def display_cars(train)
		message_debugger
		puts "#{train.cars}"
	end

	def display_trains
		message_debugger
		puts "#{Train.trains}"
	end
end