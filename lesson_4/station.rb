class Station
  attr_reader :name, :trains

  def initialize(name)
    @trains = []
    @name = name
  end

  # Прибытие поезда
  def train_arrival(train)
    @trains << train
  end

  # Отправление поезда
  def train_departure(train)
    @trains.delete(train)
  end

  def trains_type(type)
    @trains.select { |train| train.type == type }
  end

  # Получение списка поездов на станции с возможностью выбора типа поездов
  def get_trains(type = nil)
    if type == :passenger
      trains_type(type)
    elsif type == :cargo
      trains_type(type)
    else
      @trains.each_with_index{ |train, index| puts "#{index + 1} - поезд номер #{train.train_number} - #{train.type}" }
    end
  end
  
end
