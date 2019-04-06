class PassengerTrain < Train

  def initialize(train_number)
    super train_number
    @type = :passenger
  end

end
