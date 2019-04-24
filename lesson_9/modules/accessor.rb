module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value| 
        instance_variable_set(var_name, value)
        @values = []
        @values << value
      end 
    end
  end

  def strong_attr_accessor(attr_name, class_name)

  end
end
