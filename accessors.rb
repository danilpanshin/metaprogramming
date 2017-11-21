module Acessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|

        name_history = "@#{name}_history".to_sym
        var_name = "@#{name}".to_sym

        define_method(name) { instance_variable_get(var_name) }
        define_method("@#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(name_history, []) if instance_variable_get(name_history).nil?
          instance_variable_set(name_history, send("#{name}_history".to_sym) << value)
        end

        define_method("#{name}_history".to_sym) { instance_variable_get(name_history) }
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise "Wrong Class name #{type}" unless value.class == type
        instance_variable_set(var_name, value)
      end
    end
  end
end
