module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, type_of_validation, option = nil)
      @attr_name = attr_name.to_sym
      @type_of_validation = type_of_validation.to_sym
      @option = option
    end
  end

  module InstanceMethods
    def validate!
      if self.class_variable_get(:@type_of_validation) == :presence
        raise 'Имя не должно быть пустым' if @attr_name.empty?
      elsif @type_of_validation == :format
        raise 'Номер поезда не соответствует формату' if train_number !~ NUMBER_FORMAT
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end