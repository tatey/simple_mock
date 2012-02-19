require 'delegate'
require 'forwardable'
require 'minitest/mock'

require 'simple_mock/mock_delegator'
require 'simple_mock/tracer'
require 'simple_mock/version'

module SimpleMock

  # Returns a mock instance. For classicial mocking, call +new+ without
  # an argument.
  #
  #   mock = SimpleMock.new
  #   mock.expect :meaning_of_life, 42
  #   mock.meaning_of_life # => 42
  #   mock.verify # => true
  #
  # For hybrid mocking call +new+ with an +object+ argument. Hybrid mocking
  # mixes expectations with real objects.
  #
  #  mock = SimpleMock.new Array.new
  #  mock.expect :meaning_of_life, 42
  #  mock.meaning_of_life # => 42
  #  mock.push(1) # => [1]
  #  mock.verify # => true
  #
  # +MiniTest::Mock+ and +SimpleMock::MockDelegator+ have a 100% compatible API
  # making no difference to the consumer.
  def self.new object = nil
    if object.nil?
      MiniTest::Mock.new
    else
      MockDelegator.new object
    end
  end
end
