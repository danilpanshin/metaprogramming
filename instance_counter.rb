
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance

    def instances
      self.instance ||= 0
      self.instance += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances
    end
  end
end
