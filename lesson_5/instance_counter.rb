module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      @instance ||= 0
    end

    protected

    def register
      @instance ||= 0
      @instance += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.send :register
    end
  end
end