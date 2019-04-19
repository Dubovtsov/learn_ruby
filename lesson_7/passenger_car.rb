class PassengerCar < Car
  attr_accessor :number_of_seats, :seats, :type
  def initialize(manufacturer_name, number_of_seats)
    super(manufacturer_name)
    @type = :passenger
    @number_of_seats = number_of_seats
    @seats = []
  end

  # Занять место в вагоне
  def place_is_taken
    @number_of_seat ||= 0
    @seats << @number_of_seat += 1 if @number_of_seat < @number_of_seats
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
