class CargoTrain < Train

  def initialize(train_number)
    super train_number
    @type = "Грузовой"
  end

end
