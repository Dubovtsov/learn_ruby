require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :start_station, :end_station
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stops = []
    validate!
    register_instance
  end

  def add_station(station)
    @stops << station
  end

  def remove_station(station)
    @stops.delete station
  end

  def train_route
    [@start_station, @stops, @end_station].flatten
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Название начальной станции не может быть пустым' if start_station.empty?
    raise 'Название конечной станции не может быть пустым' if end_station.empty?
  end
end
