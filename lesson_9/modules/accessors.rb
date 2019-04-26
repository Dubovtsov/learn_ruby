module Accessors
  def attr_accessor_with_history(*names)

    names.each do |name|
      # history_method_name = "#{name}_history".to_sym
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history_values ||= send(:values=)

        # instance_variable_set("@values", [])
        history_values << value
        puts history_values
      end
      define_method(:values) do
        instance_variable_get("@values")
      end
      define_method(:values=) do
        instance_variable_set("@values", [])
      end
    end
  end

  def strong_attr_accessor(attr_name, class_name)

  end
    
end
