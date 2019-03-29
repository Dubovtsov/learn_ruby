class Train
  attr_reader :number_of_cars, :speed, :type, :car_number, :current_station, :route
  $trains = {}

  def initialize(car_number, type, number_of_cars)
    @car_number = car_number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
    @route = []
    $trains[@car_number] = [@type, @number_of_cars]
    @station_index = 0
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
    @station_index = 0
    @current_station = @route.train_route.first
    @arrival_station = @route.train_route.last
  end

  def next_station
    @route.train_route[@station_index + 1]
  end

  def previous_station
    @route.train_route[@station_index - 1]
  end

  def move_forward
    @station_index = @route.train_route.index(@current_station) + 1
    @current_station = @route.train_route[@station_index]
  end

  def move_backward
    @station_index = @route.train_route.index(@current_station) - 1
    @current_station = @route.train_route[@station_index]
  end
end
