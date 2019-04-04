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

  # def shedule
  #   train_route.each_with_index{ |station, index| puts "#{index + 1} - #{station.name}" }
    
  #   "#{@start_station.name} - #{@end_station.name}, всего #{train_route.size} станций"
  # end
end
