require_relative 'manufacturer'
class Car
  include Manufacturer

  def initialize
    @manufacturer_name = "China"
  end

  def show_type
    puts "#{@type}"
  end
end
