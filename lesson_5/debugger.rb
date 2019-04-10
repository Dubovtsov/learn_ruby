module Debugger
  def debugger_message
    puts "!!! ИНФОРМАЦИЯ ДЛЯ ОТЛАДКИ !!!"
  end

  def debugger_display_cars(train)
    debugger_message
    puts "#{train.cars}"
  end

  def debugger_display_trains
    debugger_message
    puts "#{Train.trains}"
  end

  def debugger_display_stations
    debugger_message
    puts "#{Station.all}"
  end
end
