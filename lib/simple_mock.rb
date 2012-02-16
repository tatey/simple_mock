require 'delegate'
require 'minitest/mock'

require 'simple_mock/mock_delegator'
require 'simple_mock/tracer'
require 'simple_mock/version'

module SimpleMock
  def self.new object = nil
    if object.nil?
      MiniTest::Mock.new
    else
      MockDelegator.new object
    end
  end
end
