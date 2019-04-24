# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/accessors'

class Station
  include InstanceCounter
  extend Accessors
  include Accessors

  attr_reader :name, :trains
  attr_accessor_with_history :name

  @stations = []

  def initialize(name)
    @trains = []
    @name = name
    validate!
    self.class.stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  class << self
    attr_reader :stations
  end

  def train_arrival(train)
    @trains << train
  end

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
