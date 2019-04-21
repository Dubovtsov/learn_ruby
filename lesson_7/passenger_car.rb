class PassengerCar < Car
  attr_accessor :number_of_seats, :seats, :type
  def initialize(manufacturer_name, number_of_seats)
    @type = :passenger
    @number_of_seats = number_of_seats
    @seats = []
    validate!
    super(manufacturer_name)
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

  protected

  def validate!
    raise "Не задано количество мест в вагоне!" if @number_of_seats <= 0
  end
end
