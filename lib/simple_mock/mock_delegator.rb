module SimpleMock
  class MockDelegator < SimpleDelegator
    extend Forwardable

    attr_accessor :__tracer
    delegate :verify => :__tracer

    def initialize object
      super
      self.__tracer = Tracer.new
    end

    # Expect that method +name+ is called, optionally with +args+, and returns
    # +retval+.
    #
    #   mock.expect :meaning_of_life, 42
    #   mock.meaning_of_life # => 42
    #
    #   mock.expect :do_something_with, true, [some_obj, true]
    #   mock.do_something_with some_obj, true # => true
    #
    # +args+ is compared to the expected args using case equality (ie, the
    # '===' method), allowing for less specific expectations.
    #
    #   mock.expect :uses_any_string, true, [String]
    #   mock.uses_any_string 'foo' # => true
    #   mock.verify  # => true
    #
    #   mock.expect :uses_one_string, true, ['foo']
    #   mock.uses_one_string 'bar' # => true
    #   mock.verify  # => raises MockExpectationError
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
