module SimpleMock
  class MockDelegator < SimpleDelegator
    extend Forwardable

    attr_accessor :__tracer
    delegate :verify => :__tracer

    def initialize object
      super
      self.__tracer = Tracer.new
    end

    def expect name, retval, args = []
      method_definition = Module.new do
        define_method name do |*args, &block|
          __tracer.assert name, args
          retval
        end
      end
      extend method_definition
      __tracer.register name, args
      self
    end
  end
end
