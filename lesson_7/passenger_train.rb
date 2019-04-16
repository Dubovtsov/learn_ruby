class PassengerTrain < Train
  def initialize(train_number, manufacturer_name = nil)
    @type = :passenger
    super
  end
end
