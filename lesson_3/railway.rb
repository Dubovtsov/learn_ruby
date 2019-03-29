class Station
  attr_reader :name, :trains
  $stations = []

  def initialize(name)
    @trains = []
    @name = name
    $stations << @name
  end

  def Station.stations
    puts $stations
  end

  # Прибытие поезда
  def train_arrival(car_number)
    @trains << car_number
  end

  # Отправление поезда
  def train_departure(car_number)
    @trains.delete(car_number)
  end

  # Получение списка поездов на станции с возможностью выбора типа поездов
  def get_trains(type = nil)
    if type == "passenger"
      @trains.select { |train| train.type == type }
    elsif type == "cargo"
      @trains.select { |train| train.type == type }
    else
      trains
    end
  end

  def trains
    @trains
  end
end


class Train
  attr_reader :number_of_cars, :speed, :type, :car_number, :current_station, :route
  $trains = {}

  def initialize(car_number, type, number_of_cars)
    @car_number = car_number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
    @route = []
    $trains[@car_number] = [@type, @number_of_cars]
    @current_station = 0
  end

  # Метод набора скорости
  def speed_up(speed = 1)
    @speed += speed
  end
  # Метод торможения
  def speed_down(braking = 1)
    @speed -= braking
    @speed = 0 if @speed < 0
  end

  # Зацепить вагон
  def hook_car
    # Сначало поезд должен остановиться
    @number_of_cars += 1 if @speed == 0
  end

  # Отцепить вагон
  def unhook_car
    # Сначало поезд должен остановиться
    @number_of_cars -= 1 if @speed == 0 && @number_of_cars > 0
  end

  def route(route_train)
    
    route_train.each { |station| @route << station }
    @current_station = @route.first
    # puts @current_station
  end

  # def current_station
  #   puts @current_station
  # end

  def next_station

  end

  def previous_station

  end

  def move_forward
    
  end

  def move_backward
    
  end
end

# Класс Train (Поезд):
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута


class Route
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stops = []
  end

  def add_station(station)
    @stops << station
  end

  def remove_station(station)
    @stops.delete station
  end

  def train_route
    # Метод .flatten преобразует многомерный массив в одномерный
    [@start_station, @stops, @end_station].flatten
  end

  def shedule
    puts train_route
  end
end

# Проверка работы классов

moscow = Station.new("Moscow")
spb = Station.new("Spb")
tver = Station.new("Tver")

Station.stations

puts "Список поездов"
train_808 = Train.new(808, "passenger", 12)
train_909 = Train.new(909, "cargo", 18)
train_1001 = Train.new(1001, "passenger", 12)

puts $trains

route_to_spb = Route.new(moscow.name, spb.name)
route_to_spb.add_station(tver.name)
puts "Маршрут до Питера"
route_to_spb.shedule

train_808.route(route_to_spb.shedule)