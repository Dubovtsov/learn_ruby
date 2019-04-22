# frozen_string_literal: true

require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'station.rb'
require_relative 'car.rb'
require_relative 'cargo_car.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_car.rb'
require_relative 'passenger_train.rb'
require_relative 'menu.rb'
require_relative 'manufacturer.rb'
require_relative 'debugger.rb'
require_relative 'instance_counter.rb'

Menu.new.run
