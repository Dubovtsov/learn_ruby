# module InstanceCounter
#   def self.instances
#     @instances ||= 0
#   end

#   protected

#   def register_instance
#     self.class.instances += 1
#   end
# end

module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_writer :instances
    @instances = 0
    # def instances
    #   @instances
    # end
  end

  module InstanceMethods
    private

    def register_instance
      @instances += 1
    end
  end
end