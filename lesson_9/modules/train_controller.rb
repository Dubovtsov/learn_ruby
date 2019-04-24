# frozen_string_literal: true

module TrainController
  def add_train(train_number, type)
    if type == 2
      cargo_train = CargoTrain.new(train_number, 'ChinaTrain')
      @trains << cargo_train
      message_add_train(train_number, cargo_train.type)
    else
      passenger_train = PassengerTrain.new(train_number, 'ChinaTrain')
      @trains << passenger_train
      message_add_train(train_number, passenger_train.type)
    end
  end

  def move(train, input)
    if input == 1
      train.move_forward
      message_station(train.current_station.name)
    elsif input == 2
      train.move_backward
      message_station(train.current_station.name)
    else
      message_wrong_input
    end
    separator
    menu
  end

  def hook(train, input, car = nil)
    if input == 1
      train.hook_car(car)
      message_train_cars_size(train.cars.size)
      train.each_cars { |car| puts car }
      # with_separator(debugger_display_cars(train))
    elsif input == 2
      train.unhook_car
      message_train_cars_size(train.cars.size)
    else
      message_wrong_input
    end
    separator
    menu
  end
end
