class CargoCar < Car
  def initialize
    @type = :cargo
    @car_capacity = 30 # 30 тонн
    @cargo_inside = []
    super
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
    @cargo_inside.sum
  end
  
  # Свободный объем
  def free_space
    @free_space = @car_capacity - @cargo_inside.sum
  end
end
