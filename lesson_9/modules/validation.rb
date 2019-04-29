# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, type, option = nil)
      @validators ||= {}
      var_name = "@#{attr_name}".to_sym
      @validators["#{var_name}_#{type}"] = {
        name: var_name, type: type, option: option
      }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end

  protected

  def validate!
    validators = self.class.instance_variable_get(:@validators) || []
    validators.each do |_key, validator|
      value = instance_variable_get(validator[:name])
      case validator[:type]
      when :presence
        raise 'Имя не должно быть пустым' if value.nil? || value == ''
      when :type
        raise 'Неверный тип' unless value.is_a? validator[:option]
      when :format
        raise 'Номер поезда не соответствует формату' if value !~ validator[:option]
      end
    end
    true
  end
end
