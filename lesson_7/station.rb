require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @trains = []
    @name = name
    validate!
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
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

  def each_trains_on_station
    @trains.each { |train| yield(train) } if block_given?
  end

  protected

  def validate!
    raise 'Имя не должно быть пустым' if name.empty?
    raise 'Имя станции должно быть не менее 4 символов' if name.length < 4
  end
end
