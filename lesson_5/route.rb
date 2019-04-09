class Route
  attr_reader :start_station, :end_station
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stops = []
  end

  def add_station(station)
    @stops << station
  end

  def remove_station(station)
    @stops.delete station
  end

  def train_route
    # Метод .flatten преобразует многомерный массив в одномерный
    [@start_station, @stops, @end_station].flatten 
  end
end
