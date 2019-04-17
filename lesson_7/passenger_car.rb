class PassengerCar < Car
  def initialize
    @type = :passenger
    @number_of_seats = 30
    @seats = []
    super
  end

  # Занять место в вагоне
  def place_is_taken
    @number_of_seat ||= 0
    @seats << @number_of_seat += 1 if @number_of_seat < 30
  end

  # Освободить место в вагоне
  def place_is_free
    @seats.pop unless @seats.nil?
  end

  # Кол-во занятых мест в вагоне
  def number_of_occupied_places
    @seats.size
  end

  # Кол-во свободных мест в вагоне
  def number_of_empty_seats
    @number_of_empty_seats = @number_of_seats - @seats.size
  end
end
