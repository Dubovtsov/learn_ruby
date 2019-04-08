class Menu
  @trains = []
  @stations = []
  @routes = []

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

  def run
    Menu.top_menu
    loop do
    choise = gets.chomp
    case choise
      when "menu"
        Menu.menu
        Menu.separator
      
      when "1"
        Menu.menu_add_station
        Menu.separator
      
      when "2"
        Menu.menu_add_train
        Menu.separator
      when "3"
        Menu.menu_add_route
        Menu.separator

      when "4"
        Menu.menu_add_stop
        Menu.separator
      
      when "5"
        puts "Список всех станций"
        Menu.show_stations
        Menu.separator

      when "6"
        puts "Список всех поездов"
        Menu.show_trains
        Menu.separator

      when "7"
        puts "Список доступных маршрутов"
        Menu.show_routes
        Menu.separator

      when "8"
        Menu.menu_list_trains_on_station
        Menu.separator

      when "9"
        Menu.menu_set_route
        Menu.separator

      when "10"
        Menu.menu_hook
        Menu.separator

      when "11"
        Menu.menu_move
        Menu.separator

      when "12"
        break

      else
        puts "Error!"
      end
    end
  end

  def self.top_menu
    separator
    puts "Что вы хотите сделать? Введите цифру для выполнения операции"
    separator
    menu
    separator
  end

  def self.separator
    puts "-------------------------------------------------------------"
  end

  def self.menu
    @menu.each { |key, value| puts "#{key} => #{value}" }
  end

  def self.menu_add_station
    puts "Введите название станции:"
    name_station = gets.chomp
    station_include(name_station)
    puts "Добавлена новая станция: #{name_station}"
  end

  def self.menu_add_train
    puts "Введите номер поезда:"
    train_number = gets.to_i
    puts "Выберите тип поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
    type = gets.to_i
    add_train(train_number, type)
  end

  def self.menu_add_route
    puts "Введите начальную станцию:"
    start_station = gets.chomp
    puts "Введите конечную станцию:"
    end_station = gets.chomp
    @routes << Route.new(station_include(start_station), station_include(end_station))
    puts "Добавлен маршрут от #{start_station} до #{end_station}"
  end

  def self.menu_add_stop
    puts "Введите номер маршрута из списка:"
    show_routes
    get_route = gets.to_i
    puts "Введите название остановки:"
    stop = gets.chomp
    route = @routes[get_route - 1]
    route.add_station(station_include(stop))
    show_route(route)
  end

  def self.menu_list_trains_on_station
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
  end

  def self.menu_set_route
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
  end

  def self.menu_hook
    puts "Выберите поезд из списка:"
    show_trains
    index_train = gets.to_i
    train = @trains[index_train -1]
    puts "Введите 1 => Прицепить вагон"
    puts "Введите 2 => Отцепить вагон"
    input = gets.to_i
    hook(train, input)
  end

  def self.menu_move
    puts "Выберите поезд из списка:"
    show_trains
    index_train = gets.to_i
    train = @trains[index_train -1]
    puts "Введите 1 => Отправить поезд вперед"
    puts "Введите 2 => Отправить поезд назад"
    input = gets.to_i
    move(train, input)
  end

  def self.station_include(name_station)
    if @stations.any? { |station, index| station.name == name_station }
      return @stations.select{ |station| station.name == name_station }
    else
      @stations << Station.new(name_station)
      return @stations.select{ |station| station.name == name_station }
    end
  end

  def self.show_route(route)
    route.train_route.each_with_index { |station, station_index| print " -> " if station_index > 0; print station.name }
    print "\n"
  end

  def self.show_routes
    @routes.each_with_index do |route, index|
      print "#{index + 1} - "
      show_route(route)
    end
  end

  def self.show_trains
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type}" }
  end

  def self.show_stations
    @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def self.add_train(train_number, type)
    if type == 2
      @trains << CargoTrain.new(train_number)
      puts "Добавлен новый грузовой поезд номер: #{train_number}"
    else
      @trains << PassengerTrain.new(train_number)
      puts "Добавлен новый пассажирский поезд номер: #{train_number}"
    end
  end

  def self.move(train, input)
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

  def self.hook(train, input)
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
end
