class CargoTrain < Train
  def initialize(train_number, manufacturer_name = nil)
    @type = :cargo
    super
  end
end
