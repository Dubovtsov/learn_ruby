require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  
  attr_reader :speed, :type, :train_number, :current_station, :route, :cars

  NUMBER_FORMAT = /^([A-Z0-9]{3})-?([A-Z0-9]{2})$/i
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

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.find(train_number)
    @@trains[train_number]
  end

  def self.trains
    @@trains
  end

  # Метод набора скорости
  def speed_up(speed = 1)
    @speed += speed
  end
  # Метод торможения
  def speed_down(braking = 1)
    @speed -= braking
    @speed = 0 if @speed < 0
    return @speed
  end

  # Зацепить вагон
  def hook_car(new_car)
    @cars << new_car if @speed == 0
  end

  # Отцепить вагон
  def unhook_car
    # Сначало поезд должен остановиться
    @cars.pop if @speed == 0 && @cars.length > 0
  end

  def show_cars
    puts "#{@cars.size}"
  end

  def each_cars(train, &block)
    if block_given?
      train.cars.each { yield(train) }
    else
      puts "#{@cars}"
    end
  end

  def set_route(new_route)
    @route = new_route
    @current_station = @route.train_route.first
    @current_station_index = @route.train_route.index(@current_station)
    @current_station.train_arrival(self)
  end

  def next_station
    @route.train_route[@current_station_index + 1] if @route.train_route.size > @current_station_index + 1
  end

  def previous_station
    @route.train_route[@current_station_index - 1] if @current_station_index > 0
  end

  def move_forward
    @current_station_index += 1 if @route.train_route.size > @current_station_index + 1
    move_train
  end

  def move_backward
    @current_station_index -= 1 if @current_station_index > 0
    move_train
  end

  protected

  def validate!
    raise "Номер поезда не должен быть пустым" if train_number.empty?
    raise "Номер поезда должен быть не менее 5 символов" if train_number.length < 5
    raise "Номер поезда не соответствует формату" if train_number !~ NUMBER_FORMAT
    raise "Не указан тип поезда" if @type.empty?
  end
  
  # Вызывается другими методами. Самостоятельно не используется 
  def move_train
    @current_station.train_departure(self)
    @current_station = @route.train_route[@current_station_index]
    @current_station.train_arrival(self)
  end
end
