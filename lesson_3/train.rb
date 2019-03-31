class Train
  attr_reader :number_of_cars, :speed, :type, :train_number, :current_station, :route

  def initialize(train_number, type, number_of_cars)
    @train_number = train_number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
  end

  # Метод набора скорости
  def speed_up(speed = 1)
    @speed += speed
  end
  # Метод торможения
  def speed_down(braking = 1)
    @speed -= braking
    @speed = 0 if @speed < 0
  end

  # Зацепить вагон
  def hook_car
    # Сначало поезд должен остановиться
    @number_of_cars += 1 if @speed == 0
  end

  # Отцепить вагон
  def unhook_car
    # Сначало поезд должен остановиться
    @number_of_cars -= 1 if @speed == 0 && @number_of_cars > 0
  end

  def route(route)
    @route = route
    @current_station = @route.train_route.first
    @current_station_index = @route.train_route.index(@current_station)
  end

  def next_station
    @route.train_route[@current_station_index + 1] if @route.train_route.size > @current_station_index + 1
  end

  def previous_station
    @route.train_route[@current_station_index - 1] if @current_station_index > 0
  end

  def move_forward
    @current_station_index += 1 if @route.train_route.size > @current_station_index + 1
    @current_station = @route.train_route[@current_station_index]
    move_train
  end

  def move_backward
    @current_station_index = @route.train_route.index(@current_station_index) - 1 if @current_station_index > 0
    @current_station = @route.train_route[@current_station_index]
    move_train
  end
end

def move_train
  @current_station.train_arrival(self)
  @current_station = @route.stations[@current_station_index]
  @previous_station.train_departure(self)
end

# def change_current_station
#     @current_station.send_train(self) unless @current_station == nil
#     @current_station = @route.stations[@current_station_index]
#     @current_station.take_train(self) 
#   end