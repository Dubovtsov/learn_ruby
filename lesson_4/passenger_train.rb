class PassengerTrain < Train

  def initialize(train_number)
    super train_number
    @type = "Пассажирский"
    @speed = 0
    @cars = []
  end

  def hook(car)
    hook_car(car) if car.is_a? PassengerCar
  end
end