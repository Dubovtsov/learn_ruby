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

menu = { 1: "Добавить новую ж/д станцию введите", 
         2: "Чтобы добавить новый поезд введите",
         3: "Чтобы добавить новый маршрут введите",
         4:
         5:
         6:
         7:
         8:
         9: }
separator
puts "Что вы хотите сделать?"
separator
puts "Чтобы добавить новую ж/д станцию введите -   1"
puts "Чтобы добавить новый поезд введите -         2"
puts "Чтобы добавить новый маршрут введите -       3"
puts "Чтобы добавить остановку в маршрут введите - 4"
puts "Список станций -                             5"
puts "Список поездов -                             6"
puts "Список поездов на станции -                  7"
puts "Добавить маршрут поезду -                    8"
puts "Завершить выполнение программы -             10"
separator

loop do

  choise = gets.chomp

  def station_include(name_station)
    if @stations.any? { |station, index| station.name == name_station }
      puts "Станция уже есть в списке"
    else
      @stations << Station.new(name_station)
      puts "Добавлена новая станция: #{name_station}"
    end
  end

  case choise
    when "stop"
      break

    when "stations"
      @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
    
    when "trains"
      @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type}" }
    
    when "routes"
      @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.shedule}" }
    
    when "create s"
      puts "Введите название станции:"
      name_station = gets.chomp
      station_include(name_station)
    
    when "create train"
      puts "Введите номер поезда:"
      train_number = gets.to_i
      puts "Поезд пассажирский или грузовой?"
      type = gets.chomp
      if type == "грузовой"
        @trains << CargoTrain.new(train_number)
        puts "Добавлен новый грузовой поезд: #{train_number}"
      else
        @trains << PassengerTrain.new(train_number)
        puts "Добавлен новый пассажирский поезд: #{train_number}"
      end
    
    when "create route"
      puts "Введите начальную станцию:"
      start_station = gets.chomp
      station_include(start_station)
      puts "Введите конечную станцию:"
      end_station = gets.chomp
      station_include(end_station)
      @routes << Route.new(start_station, end_station)
      puts "Добавлен маршрут от #{start_station} до #{end_station}"
      separator
      puts "Хотите добавить остановки в маршрут?"
      puts "Чтобы добавить введите - add stop"
      puts "Список доступных маршрутов:"
      @routes.each_with_index { |route, index| puts "#{index + 1} - #{route.shedule}" }
      separator

    when "add stop"
      puts "Введите номер маршрута из списка:"
      get_route = gets.to_i
      puts "Введите название остановки:"
      stop = gets.chomp
      station_include(stop)
      route = @routes[get_route - 1]
      route.add_station(stop)
    else
      puts "Error!"
  end
end

# Определить, какие методы могут быть помещены в private/protected 
# и вынести их в такую секцию. В комментарии к методу обосновать, 
# почему он был вынесен в private/protected
# К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
