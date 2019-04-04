require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'seeds.rb'

@trains = []
@stations = []
@routes = []

def separator 
  puts "-------------------------------------------------------------"
end

menu = { 1 => "Добавить новую ж/д станцию", 
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
separator
puts "Что вы хотите сделать? Введите цифру для выполнения операции"
separator
menu.each { |key, value| puts "#{key} => #{value}" }
separator

loop do

  choise = gets.chomp

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
    # @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.start_station} => #{route.end_station}" }
  end

  def show_trains
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type}" }
  end

  def show_stations
    @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  case choise
    when "menu"
      menu.each { |key, value| puts "#{key} => #{value}" }
      separator
    
    when "1"
      puts "Введите название станции:"
      name_station = gets.chomp
      station_include(name_station)
      puts "Добавлена новая станция: #{name_station}"
      separator
    
    when "2"
      puts "Введите номер поезда:"
      train_number = gets.to_i
      puts "Поезд пассажирский или грузовой?"
      type = gets.chomp
      if type == "грузовой"
        @trains << CargoTrain.new(train_number)
        puts "Добавлен новый грузовой поезд номер: #{train_number}"
      else
        @trains << PassengerTrain.new(train_number)
        puts "Добавлен новый пассажирский поезд номер: #{train_number}"
      end
      separator
    
    when "3"
      puts "Введите начальную станцию:"
      start_station = gets.chomp
      puts "Введите конечную станцию:"
      end_station = gets.chomp
      @routes << Route.new(station_include(start_station), station_include(end_station))
      puts "Добавлен маршрут от #{start_station} до #{end_station}"
      separator
      puts "Хотите добавить остановки в маршрут?"
      puts "Чтобы добавить введите - 4"
      separator

    when "4"
      puts "Введите номер маршрута из списка:"
      show_routes
      get_route = gets.to_i
      puts "Введите название остановки:"
      stop = gets.chomp
      route = @routes[get_route - 1]
      route.add_station(station_include(stop))
      show_route(route)
      separator
    
    when "5"
      puts "Список всех станций"
      show_stations
      separator
    when "6"
      puts "Список всех поездов"
      show_trains
      separator
    when "7"
      puts "Список доступных маршрутов"
      show_routes

    when "8"
      if @stations.empty?
        puts "Сначало добавьте станции"
      else
        puts "Выберите станцию"
        show_stations
        index_station = gets.to_i
        station = @stations[index_station -1]
        puts "Список поездов на станции:"
        puts "Нет поездов на станции" if station.get_trains.empty?
        station.get_trains
      end
      separator

    when "9"
      puts "Выберите поезд"
      show_trains
      index_train = gets.to_i
      train = @trains[index_train -1]
      puts "Выберите маршрут"
      show_routes
      index_route = gets.to_i
      route = @routes[index_route - 1]
      train.set_route(route)
      puts "Поезд прибыл на станцию - #{train.current_station.name}"
      separator

    when "10"
      puts "Выберите поезд из списка:"
      show_trains
      index_train = gets.to_i
      train = @trains[index_train -1]
      puts "#{train.type}"
      puts "Введите 1 => Прицепить вагон"
      puts "Введите 2 => Отцепить вагон"
      input = gets.to_i
      if input == 1
        train.hook_car(train.type)
        puts "Поезд состоит из #{train.cars.size} вагона(ов)"
      elsif input == 2
        train.unhook_car
        puts "Поезд состоит из #{train.cars.size} вагона(ов)"
      else
        puts "Введено неверное значение!"
      end
      separator
      
    when "11"
      puts "Выберите поезд из списка:"
      show_trains
      index_train = gets.to_i
      train = @trains[index_train -1]
      puts "Введите 1 => Отправить поезд вперед"
      puts "Введите 2 => Отправить поезд назад"
      input = gets.to_i
      if input == 1
        train.move_forward
        puts "Поезд прибыл на станцию - #{train.current_station.name}"
      elsif input == 2
        train.move_backward
        puts "Поезд прибыл на станцию - #{train.current_station.name}"
      else
        puts "Введено неверное значение!"
      end
      separator

    when "12"
      break

    else
      puts "Error!"
  end
end

# Определить, какие методы могут быть помещены в private/protected 
# и вынести их в такую секцию. В комментарии к методу обосновать, 
# почему он был вынесен в private/protected
# К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
# Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад