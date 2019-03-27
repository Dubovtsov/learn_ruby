class Station

  def initialize(name)
    @trains = []
    @stations = []
    @name = name
    @stations << @name
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
      @trains
    end
  end

  def trains
    @trains
  end
end


class Train
  attr_reader :number_of_cars, :speed, :type, :car_number

  def initialize(car_number, type, number_of_cars)
    @car_number = car_number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
  end

  def speed

  end
end

# Класс Train (Поезд):
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, 
# метод просто увеличивает или уменьшает количество вагонов). 
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
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

end


# Класс Route (Маршрут):
# Может выводить список всех станций по-порядку от начальной до конечной
#