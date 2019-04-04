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
         10 => "Завершить выполнение программы" }
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

  def show_routes
    @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.train_route}" }
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
        puts "Добавлен новый грузовой поезд: #{train_number}"
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
      puts "Список доступных маршрутов:"
      @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.train_route}" }
      separator

    when "4"
      puts "Введите номер маршрута из списка:"
      get_route = gets.to_i
      puts "Введите название остановки:"
      stop = gets.chomp
      route = @routes[get_route - 1]
      route.add_station(station_include(stop))
      puts "#{route.train_route}"
      separator
    
    when "5"
      puts "#{@stations.flatten}"
      # show_stations
  
    when "6"
      show_trains    
    when "7"
      show_routes    
    when "8"
      if @stations.empty?
        puts "Сначало добавьте станции"
      else
        puts "Выберите станцию"
        show_stations
        index_station = gets.to_i
        station = @stations[index_station -1]
        station.get_trains
      end
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
    when "10"
      break

    else
      puts "Error!"
  end
end

# Определить, какие методы могут быть помещены в private/protected 
# и вынести их в такую секцию. В комментарии к методу обосновать, 
# почему он был вынесен в private/protected
# К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
