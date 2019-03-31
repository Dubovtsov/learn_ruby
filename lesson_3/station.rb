class Station
  attr_reader :name, :trains

  def initialize(name)
    @trains = []
    @name = name
  end

  # Прибытие поезда
  def train_arrival(train_number)
    @trains << train_number
  end

  # Отправление поезда
  def train_departure(train_number)
    @trains.delete(train_number)
  end

  def trains_type(type)
    @trains.select { |train| train.type == type }
  end

  # Получение списка поездов на станции с возможностью выбора типа поездов
  def get_trains(type = nil)
    if type == "passenger"
      trains_type(type)
    elsif type == "cargo"
      trains_type(type)
    else
      trains
    end
  end
end
