require_relative "modules/accessors.rb"

class TestApp
  include Accessors
  extend Accessors

  attr_accessor_with_history :name

  def initialize(name)
    @name = name
  end
end

test = TestApp.new("moscow")

# puts test.name
test.name = "Tver"
# puts test.name
test.name = "Kukuevo"
test.name = "Moscow"
print test.instance_variables
print "\n"
puts test.values
