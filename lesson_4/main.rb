require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'menu'

@trains = []
@stations = []
@routes = []

separator
puts "Что вы хотите сделать? Введите цифру для выполнения операции"
separator
@menu.each { |key, value| puts "#{key} => #{value}" }
separator

loop do

  choise = gets.chomp

  case choise
    when "menu"
      @menu.each { |key, value| puts "#{key} => #{value}" }
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
      puts "Выберите тип поезда:"
      puts "1 - Пассажирский"
      puts "2 - Грузовой"
      type = gets.to_i
      add_train(train_number, type)
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
      puts "Выберите поезд из списка"
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
      # puts "#{train.type}"
      puts "Введите 1 => Прицепить вагон"
      puts "Введите 2 => Отцепить вагон"
      input = gets.to_i
      hook(train, input)
      separator

    when "11"
      puts "Выберите поезд из списка:"
      show_trains
      index_train = gets.to_i
      train = @trains[index_train -1]
      puts "Введите 1 => Отправить поезд вперед"
      puts "Введите 2 => Отправить поезд назад"
      input = gets.to_i
      move(train, input)
      separator

    when "12"
      break

    else
      puts "Error!"
  end
end
