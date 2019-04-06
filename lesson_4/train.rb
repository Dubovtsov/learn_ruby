class Train
  attr_reader :speed, :type, :train_number, :current_station, :route, :cars

  def initialize(train_number)
    @train_number = train_number
    @speed = 0
    @cars = []
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

# Вызывается другими методами. Самостоятельно не используется 
  def move_train
    @current_station.train_departure(self)
    @current_station = @route.train_route[@current_station_index]
    @current_station.train_arrival(self)
  end
end
