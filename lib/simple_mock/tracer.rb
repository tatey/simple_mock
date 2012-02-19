module SimpleMock
  class Tracer
    attr_accessor :actual_calls, :expected_calls

    def initialize
      self.actual_calls   = {}
      self.expected_calls = {}
    end

    def assert name, actual_args = []
      expected_args = expected_calls[name]
      unless expected_args.size == actual_args.size
        raise MockExpectationError, "mocked method :#{name} expects #{expected_args.size} arguments, got #{actual_args.size}"
      end
      unless expected_args.zip(actual_args).all? { |e, a| e === a || e == a }
        raise MockExpectationError
      end
      actual_calls[name] = true
    end

    def register name, args = []
      expected_calls[name] = args
    end

    # Verify that all methods were called as expected. Raises
    # +MockExpectationError+ if not called as expected.
    def verify
      if (expected_calls.keys - actual_calls.keys).any?
        raise MockExpectationError
      else
        true
      end
    end
  end
end
