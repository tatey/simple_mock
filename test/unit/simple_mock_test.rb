require 'helper'

class SimpleMockTest < MiniTest::Unit::TestCase
  def test_new_without_argument_returns_minitest_mock
    assert_instance_of MiniTest::Mock, SimpleMock.new
  end

  def test_new_with_argument_returns_mock_delegator
    assert_instance_of SimpleMock::MockDelegator, SimpleMock.new(Object.new)
  end
end
