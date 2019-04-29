# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_method_name = "#{name}_history".to_sym
      history_var = "#{var_name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history_values = send(history_method_name)
        history_values << value
      end
      define_method(history_method_name) do
        instance_variable_get(history_var) ||
          instance_variable_set(history_var, [])
      end
    end
  end

  def strong_attr_accessor(attr_name, class_name)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }

    define_method("#{attr_name}=".to_sym) do |value|
      raise 'TypeError' unless value.is_a? class_name

      instance_variable_set(var_name, value)
    end
  end
end
