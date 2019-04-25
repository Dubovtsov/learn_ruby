# frozen_string_literal: true

require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^([A-Z0-9]{3})-?([A-Z0-9]{2})$/i.freeze

  attr_reader :speed, :type, :train_number, :current_station, :route, :cars

  @@trains = {}

  def initialize(train_number, manufacturer_name = nil)
    @train_number = train_number
    @speed = 0
    @cars = []
    @manufacturer_name = manufacturer_name
    validate!
    @@trains[train_number] = self
    register_instance
  end

  def self.trains
    @@trains
  end

  def self.find(train_number)
    @@trains[train_number]
  end

  def speed_up(speed = 1)
    @speed += speed
  end

  def speed_down(braking = 1)
    @speed -= braking
    @speed = 0 if @speed.negative?
  end

  def hook_car(new_car)
    @cars << new_car if @speed.zero?
  end

  def unhook_car
    @cars.pop if @speed.zero? && !@cars.empty?
  end

  def show_cars
    @cars.size.to_s
  end

  def each_cars
    @cars.each { |car| yield(car) } if block_given?
  end

  def assign_route(new_route)
    @route = new_route
    @current_station = @route.train_route.first
    @current_station_index = @route.train_route.index(@current_station)
    @current_station.train_arrival(self)
  end

  def next_station
    @route.train_route[@current_station_index + 1] if @route.train_route.size > @current_station_index + 1
  end

  def previous_station
    @route.train_route[@current_station_index - 1] if @current_station_index.positive?
  end

  def move_forward
    @current_station_index += 1 if @route.train_route.size > @current_station_index + 1
    move_train
  end

  def move_backward
    @current_station_index -= 1 if @current_station_index.positive?
    move_train
  end

  def to_s
    "#{@type == :cargo ? 'Грузовой' : 'Пассажирский'} поезд номер #{train_number} - #{@cars.size} вагон(ов)"
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Номер поезда не должен быть пустым' if train_number.empty?
    raise 'Номер поезда должен быть не менее 5 символов' if train_number.length < 5
    # raise 'Номер поезда не соответствует формату' if train_number !~ NUMBER_FORMAT
    raise 'Не указан тип поезда' if @type.empty?
  end

  def move_train
    @current_station.train_departure(self)
    @current_station = @route.train_route[@current_station_index]
    @current_station.train_arrival(self)
  end
end
