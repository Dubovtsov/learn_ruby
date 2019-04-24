# frozen_string_literal: true

module Debugger
  def debugger_message
    puts '!!! ИНФОРМАЦИЯ ДЛЯ ОТЛАДКИ !!!'
  end

  def debugger_display_cars(train)
    debugger_message
    puts train.cars.to_s
  end

  def debugger_display_trains
    debugger_message
    puts Train.trains.to_s
  end

  def debugger_display_stations
    debugger_message
    puts Station.all.to_s
  end
end
