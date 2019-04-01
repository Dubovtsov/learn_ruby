class CargoTrain < Train

  def initialize(train_number)
    @train_number = train_number
    @type = "Грузовой"
    @speed = 0
  end
end