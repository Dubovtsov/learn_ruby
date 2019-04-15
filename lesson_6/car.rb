require_relative 'manufacturer'
class Car
  include Manufacturer

  def initialize
    @manufacturer_name = "China"
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

  protected

  def validate!
    raise "Название производителя не должно быть пустым" if @manufactured_name.empty?
    raise "Название производителя должно быть не менее 4 символов" if @manufactured_name.length < 4
    raise "Тип не должен быть пустым" if @type.empty?
  end
end
