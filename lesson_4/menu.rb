
@menu = { 1 => "Добавить новую ж/д станцию",
          2 => "Добавить новый поезд",
          3 => "Добавить новый маршрут",
          4 => "Добавить остановку в маршрут",
          5 => "Список станций",
          6 => "Список поездов",
          7 => "Список маршрутов",
          8 => "Список поездов на станции",
          9 => "Передать маршрут поезду",
          10 => "Добавить/Отцепить вагон",
          11 => "Переместить поезд по маршруту",
          12 => "Завершить выполнение программы"
        }

def separator
  puts "-------------------------------------------------------------"
end

def station_include(name_station)
  if @stations.any? { |station, index| station.name == name_station }
    return @stations.select{ |station| station.name == name_station }
  else
    @stations << Station.new(name_station)
    return @stations.select{ |station| station.name == name_station }
  end
end

def show_route(route)
  route.train_route.each_with_index { |station, station_index| print " -> " if station_index > 0; print station.name }
  print "\n"
end

def show_routes
  @routes.each_with_index do |route, index|
    print "#{index + 1} - "
    show_route(route)
  end
end

def show_trains
  @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type}" }
end

def show_stations
  @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
end

def add_train(train_number, type)
  if type == 2
    @trains << CargoTrain.new(train_number)
    puts "Добавлен новый грузовой поезд номер: #{train_number}"
  else
    @trains << PassengerTrain.new(train_number)
    puts "Добавлен новый пассажирский поезд номер: #{train_number}"
  end
end

def move(train, input)
  if input == 1
    train.move_forward
    puts "Поезд прибыл на станцию - #{train.current_station.name}"
  elsif input == 2
    train.move_backward
    puts "Поезд прибыл на станцию - #{train.current_station.name}"
  else
    puts "Введено неверное значение!"
  end
end

def hook(train, input)
  if input == 1
    train.is_a?(CargoTrain) ? train.hook_car(CargoCar.new) : train.hook_car(PassengerCar.new)
    puts "Поезд состоит из #{train.cars.size} вагона(ов)"
  elsif input == 2
    train.unhook_car
    puts "Поезд состоит из #{train.cars.size} вагона(ов)"
  else
    puts "Введено неверное значение!"
  end
end
