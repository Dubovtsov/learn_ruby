require_relative 'manufacturer'
class Car
  include Manufacturer

  def initialize(manufacturer_name)
    @manufacturer_name = manufacturer_name
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def show_type
    puts "#{@type}"
  end

  def to_s
    if @type == :cargo
      "Грузовой вагон, доступно для загрузки #{free_space} из #{@car_capacity}"
    else
      "Пассажирский вагон, свободно мест #{number_of_empty_seats} из #{@number_of_seats}"
    end
  end

  protected

  def validate!
    raise "Название производителя не должно быть пустым" if @manufacturer_name.empty?
    raise "Название производителя должно быть не менее 4 символов" if @manufacturer_name.length < 4
  end
end
