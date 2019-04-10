class PassengerTrain < Train
  def initialize(train_number, manufacturer_name = nil)
    super train_number, manufacturer_name
    @type = :passenger
    # @manufacturer_name = manufacturer_name
  end
end
