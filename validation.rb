module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, *args)
      self.validations ||= []
      self.validations[name] ||= []
      self.validations[name] << [type, args.first]
    end
  end

  module InstanceMethods

    def validate!
      self.class.validations.each do |rule|
        rule.each do |name, params|
          params.each do |param|
            var_value = instance_variable_get("@#{name.to_s}")
            send(param.first, var_value, param.last)
          end
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def presence(value)
      raise "Wrong empty value" if value.nil? || value == ''
    end

    def format(value, format)
      raise "Wrong format" if value !~ format
    end

    def type(value, class_name)
      raise "Wrong Class name #{class_name}" unless value.is_a? class_name
    end
  end
end
