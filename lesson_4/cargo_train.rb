class CargoTrain < Train
  
  def initialize(train_number, type, number_of_cars)
    @train_number = train_number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
  end
end