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
        menu_add_station
      when "2"
        menu_add_train
      when "3"
        menu_add_route
      when "4"
        menu_add_stop
      when "5"
        puts "Список всех станций"
        show_stations
        debugger_display_stations
      when "6"
        puts "Список всех поездов"
        show_trains
        debugger_display_trains
      when "7"
        puts "Список доступных маршрутов"
        show_routes
      when "8"
        menu_list_trains_on_station
      when "9"
        menu_set_route
      when "10"
        menu_hook
      when "11"
        menu_move
      when "12"
        puts "Найти поезд по номеру"
        train_number = gets.to_i
        puts Train.find(train_number) != nil ? "#{Train.find(train_number)}" : "Поезд не найден"
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
    menu
    separator
  end

  def separator
    puts "-------------------------------------------------------------"
  end

  def menu
    @menu.each { |key, value| puts "#{key} => #{value}" }
  end

  # Сообщения

  def message_add_train(train_number, type)
    puts "Добавлен новый #{type == :cargo ? "грузовой" : "пассажирский"} поезд номер: #{train_number}"
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

  def message_station(station)
    puts "Поезд прибыл на станцию - #{station}"
  end

  def message_train_cars_size(cars)
    puts "Поезд состоит из #{cars} вагона(ов)"
  end

  def menu_add_station
    puts "Введите название станции:"
    name_station = gets.chomp
    station_include(name_station)
    puts "Добавлена новая станция: #{name_station}"
    separator
    puts self.class.instances
    separator
    menu
  end

  def menu_add_train
    puts "Введите номер поезда:"
    train_number = gets.to_i
    puts "Выберите тип поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
    type = gets.to_i
    add_train(train_number, type)
    puts self.class.instances
    separator
    menu
  end

  def menu_add_route
    puts "Введите начальную станцию:"
    start_station = gets.chomp
    puts "Введите конечную станцию:"
    end_station = gets.chomp
    @routes << Route.new(station_include(start_station), station_include(end_station))
    puts "Добавлен маршрут от #{start_station} до #{end_station}"
    separator
    puts self.class.instances
    separator
    menu
  end

  def menu_add_stop
    message_select_route
    show_routes
    get_route = gets.to_i
    puts "Введите название остановки:"
    stop = gets.chomp
    route = @routes[get_route - 1]
    route.add_station(station_include(stop))
    show_route(route)
    separator
    menu
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
    message_select_train
    show_trains
    index_train = gets.to_i
    train = @trains[index_train -1]
    message_select_route
    show_routes
    index_route = gets.to_i
    route = @routes[index_route - 1]
    train.set_route(route)
    puts "Поезд прибыл на станцию - #{train.current_station.name}"
    separator
    menu
  end

  def menu_hook
    message_select_train
    show_trains
    index_train = gets.to_i
    train = @trains[index_train -1]
    puts "Введите 1 => Прицепить вагон"
    puts "Введите 2 => Отцепить вагон"
    input = gets.to_i
    hook(train, input)
  end

  def menu_move
    message_select_train
    show_trains
    index_train = gets.to_i
    train = @trains[index_train -1]
    puts "Введите 1 => Отправить поезд вперед"
    puts "Введите 2 => Отправить поезд назад"
    input = gets.to_i
    move(train, input)
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
    separator
  end

  def show_trains
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type} - #{train.manufacturer_name}" }
    separator
  end

  def show_stations
    Station.all.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
    separator
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
      debugger_display_cars(train)
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
