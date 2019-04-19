class CargoCar < Car
  attr_accessor :car_capacity, :cargo_inside, :type

  def initialize(manufacturer_name, car_capacity)
    super(manufacturer_name)
    @type = :cargo
    @car_capacity = car_capacity
    @cargo_inside = []
  end

  # Загрузка в вагон
  def loading(weight = 5)
    @cargo_inside << weight if @cargo_inside.sum < @car_capacity
  end

  # Разгрузка вагона
  def unloading
    @cargo_inside.pop unless @cargo_inside.nil?
  end

  # Занятый объем
  def cargo_inside
    puts @cargo_inside.nil? ? "Груза в вагоне: 0" : "#{@cargo_inside.sum}"
  end

  # Свободный объем
  def free_space
    @free_space = @car_capacity - @cargo_inside.sum
  end

  protected

  def validate!
    
  end
end
