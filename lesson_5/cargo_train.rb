class CargoTrain < Train
  def initialize(train_number, manufacturer_name = nil)
    super train_number, manufacturer_name
    @type = :cargo
  end
end
