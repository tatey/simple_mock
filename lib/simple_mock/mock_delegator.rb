module SimpleMock
  class MockDelegator < SimpleDelegator
    def expect name, retval, args = []
      method = Module.new do
        define_method name do |*args, &block|
          retval
        end
      end
      extend method
      self
    end

    def verify

    end

  protected

    def method_missing name, *args, &block
      super
    end
  end
end
