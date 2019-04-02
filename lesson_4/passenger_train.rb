class PassengerTrain < Train

  def initialize(train_number)
    @train_number = train_number
    @type = "Пассажирский"
    @speed = 0
    @cars = []
  end
end