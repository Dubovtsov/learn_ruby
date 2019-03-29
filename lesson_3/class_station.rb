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
