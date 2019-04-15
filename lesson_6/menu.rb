require_relative 'debugger'
class Menu
  include Debugger
  include InstanceCounter

  def initialize
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
              12 => "Найти поезд по номеру",
              13 => "Завершить выполнение программы"
            }
    @trains = []
    @stations = []
    @routes = []
  end

  def run
    top_menu
    loop do
    choise = gets.chomp
    case choise
      when "menu"
        menu
      when "1"
        with_separator(menu_add_station)
      when "2"
        with_separator(menu_add_train)
      when "3"
        with_separator(menu_add_route)
      when "4"
        with_separator(menu_add_stop)
      when "5"
        with_separator(show_stations)
        with_separator(debugger_display_stations)
      when "6"
        with_separator(show_trains)
        with_separator(debugger_display_trains)
      when "7"
        with_separator(show_routes)
      when "8"
        with_separator(menu_list_trains_on_station)
      when "9"
        with_separator(menu_set_route)
      when "10"
        with_separator(menu_hook)
      when "11"
        with_separator(menu_move)
      when "12"
        with_separator(menu_find_train)
      when "13"
        break
      else
        puts "Error!"
      end
    end
  end

  def top_menu
    separator
    puts "Что вы хотите сделать? Введите цифру для выполнения операции"
    separator
    with_separator(menu)
  end

  def separator
    puts "-------------------------------------------------------------"
  end

  def with_separator(method_name)
    method_name
    separator
  end

  def menu
    @menu.each { |key, value| puts "#{key} => #{value}" }
  end

  # Сообщения

  def message_add_train(train_number, type)
    puts "Добавлен новый #{type == :cargo ? "грузовой" : "пассажирский"} поезд номер #{train_number}"
  end

  def message_select_route
    puts "Выберите маршрут:"
  end

  def message_select_train
    puts "Выберите поезд из списка:"
  end

  def message_wrong_input
    puts "Введено неверное значение!"
  end

  def message_wrong_parameter
    puts "Выбранный параметр не соответствует списку доступных!".upcase
  end

  def message_station(station)
    puts "Поезд прибыл на станцию => #{station}"
  end

  def message_train_cars_size(cars)
    puts "Поезд состоит из #{cars} вагона(ов)"
  end

  def menu_add_station
    loop do
      puts "Введите название станции:"
      name_station = gets.chomp
      station_include(name_station)
      puts "Добавлена новая станция => #{name_station}"
      separator
      puts "Счётчик станций: #{Station.instances}"
      separator
      menu
      break
    rescue StandardError => e
      puts e.message
    end
  end

  def menu_add_train
    loop do
      puts "Введите номер поезда:"
      train_number = gets.chomp
      if train_number.scan(/\D/).empty? && !train_number.empty?
        train_number = train_number.to_i
        loop do
          puts "Выберите тип поезда:"
          puts "1 - Пассажирский"
          puts "2 - Грузовой"
          type = gets.to_i
          if type == 1 || type == 2
            add_train(train_number, type)
            puts "Счётчик грузовых поездов: #{CargoTrain.instances}"
            puts "Счётчик пассажирских поездов: #{PassengerTrain.instances}"
            separator
            menu
            break
          else
            message_wrong_parameter
          end
        end
        break
      else
        puts "Номер поезда не должен содержать букв или быть пустым!".upcase
      end
    end
  end

  def menu_add_route
    loop do
      puts "Введите начальную станцию:"
      start_station = gets.chomp
      if start_station.empty?
        puts "Вы не ввели название станции!".upcase
      else
        loop do
          puts "Введите конечную станцию:"
          end_station = gets.chomp
          if end_station.empty?
            puts "Вы не ввели название станции!".upcase
          else
            @routes << Route.new(station_include(start_station), station_include(end_station))
            puts "Добавлен маршрут от #{start_station} до #{end_station}"
            separator
            puts "Счётчик маршрутов: #{Route.instances}"
            separator
            menu
            break
          end
        end
        break
      end
    end
  end

  def menu_add_stop
    loop do
      loop do
        message_select_route
        show_routes
        get_route = gets.to_i
        if get_route == 0 || get_route > @routes.length
          message_wrong_parameter
        else
          puts "Введите название остановки:"
          stop = gets.chomp
          if stop.empty?
            puts "Вы не ввели название остановки!".upcase
          else
            route = @routes[get_route - 1]
            route.add_station(station_include(stop))
            show_route(route)
            separator
            menu
            break
          end
        end
      end
      break
    end
  end

  def menu_list_trains_on_station
    if @stations.empty?
      puts "Сначало добавьте станции"
    else
      puts "Выберите станцию"
      show_stations
      index_station = gets.to_i
      station = @stations[index_station -1]
      puts "Список поездов на станции:"
      puts "Нет поездов на станции" if station.get_trains.empty?
    end
    separator
    menu
  end

  def menu_set_route
    loop do
      loop do
        message_select_train
        show_trains
        index_train = gets.to_i
        if index_train == 0 || index_train > @trains.length
          message_wrong_parameter
        else
          train = @trains[index_train -1]
          message_select_route
          show_routes
          get_route = gets.to_i
          if get_route == 0 || get_route > @routes.length
            message_wrong_parameter
          else
            route = @routes[get_route - 1]
            train.set_route(route)
            puts "Поезд прибыл на станцию - #{train.current_station.name}"
            separator
            menu
            break
          end
        end
      end
      break
    end
  end

  def menu_hook
    loop do
      loop do
        message_select_train
        show_trains
        index_train = gets.to_i
        if index_train == 0 || index_train > @trains.length
          message_wrong_parameter
        else
          train = @trains[index_train -1]
          puts "Введите 1 => Прицепить вагон"
          puts "Введите 2 => Отцепить вагон"
          input = gets.to_i
          if input == 1 || input == 2
            hook(train, input)
            break
          else
            message_wrong_parameter
          end
          
        end
      end
      break
    end
  end

  def menu_move
    loop do
      message_select_train
      show_trains
      index_train = gets.to_i
      if index_train == 0 || index_train > @trains.length
        message_wrong_parameter
      else
        train = @trains[index_train -1]
        puts "Введите 1 => Отправить поезд вперед"
        puts "Введите 2 => Отправить поезд назад"
        input = gets.to_i
        move(train, input)
        break
      end
    end
  end

  def menu_find_train
    puts "Найти поезд по номеру"
    train_number = gets.to_i
    puts Train.find(train_number) != nil ? "#{Train.find(train_number)}" : "Поезд не найден"
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
    puts "Список доступных маршрутов"
    @routes.each_with_index do |route, index|
      print "#{index + 1} - "
      show_route(route)
    end
  end

  def show_trains
    puts "Список всех поездов"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type} - #{train.manufacturer_name}" }
  end

  def show_stations
    puts "Список всех станций"
    Station.all.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def add_train(train_number, type)
    if type == 2
      cargo_train = CargoTrain.new(train_number, "ChinaTrain")
      @trains << cargo_train
      message_add_train(train_number, cargo_train.type)
    else
      passenger_train = PassengerTrain.new(train_number, "ChinaTrain")
      @trains << passenger_train
      message_add_train(train_number, passenger_train.type)
    end
  end

  def move(train, input)
    if input == 1
      train.move_forward
      message_station(train.current_station.name)
    elsif input == 2
      train.move_backward
      message_station(train.current_station.name)
    else
      message_wrong_input
    end
    separator
    menu
  end

  def hook(train, input)
    if input == 1
      train.is_a?(CargoTrain) ? train.hook_car(CargoCar.new) : train.hook_car(PassengerCar.new)
      message_train_cars_size(train.cars.size)
      with_separator(debugger_display_cars(train))
    elsif input == 2
      train.unhook_car
      message_train_cars_size(train.cars.size)
    else
      message_wrong_input
    end
    separator
    menu
  end
end
