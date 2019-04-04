class CargoTrain < Train

  def initialize(train_number)
    super train_number
    @type = "Грузовой"
    # @speed = 0
    # @cars = []
  end
  
  def hook(car)
    hook_car(car) if car.is_a? CargoCar  	
  end

end