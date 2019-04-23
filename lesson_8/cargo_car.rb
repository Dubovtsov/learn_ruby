# frozen_string_literal: true

class CargoCar < Car
  attr_accessor :car_capacity, :cargo_inside, :type

  def initialize(manufacturer_name, car_capacity)
    @type = :cargo
    @car_capacity = car_capacity
    @cargo_inside = []
    validate!
    super(manufacturer_name)
  end

  def loading(weight = 5)
    @cargo_inside << weight if @cargo_inside.sum < @car_capacity
  end

  def unloading
    @cargo_inside.pop
  end

  def cargo_inside_car
    @cargo_inside.nil? ? 0 : @cargo_inside.sum
  end

  def free_space
    @free_space = @car_capacity - @cargo_inside.sum
  end

  protected

  def validate!
    raise 'Не задан объем!' if @car_capacity <= 0
  end
end
