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
require_relative 'modules/manufacturer.rb'
require_relative 'modules/debugger.rb'
require_relative 'modules/instance_counter.rb'
require_relative 'modules/train_controller.rb'
require_relative 'modules/accessors.rb'

Menu.new.run
