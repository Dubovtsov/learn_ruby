require_relative 'manufacturer'
class Car
	include Manufacturer

  def initialize
    # car_type = []
    @manufacturer_name = "China"
  end

  def show_type
    puts "#{@type}"
  end
end
