require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @trains = []
    @name = name
    @@stations << self
    register_instance
    validate!
  end
  
  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @@stations
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

  protected

  def validate!
    raise "Имя не должно быть пустым" if name.empty?
    raise "Имя станции должно быть не менее 5 символов" if name.length < 5
  end
end
