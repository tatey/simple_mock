require 'helper'

class MockDelegatorTest < MiniTest::Unit::TestCase
  def test_initialize_sets_delegate
    object    = Object.new
    delegator = MockDelegator.new object
    assert_equal object, delegator.__getobj__
  end

  def test_expect_returns_self
    object    = Object.new
    delegator = MockDelegator.new object
    assert_equal delegator, delegator.expect(:pop, 1)
  end

  def test_expect_defines_method_returning_value
    array = Array.new
    delegator = MockDelegator.new array
    delegator.expect :pop, 1
    assert_equal 1, delegator.pop
  end

  def test_expect_defines_method_with_argument_returning_value
    array = Array.new
    delegator = MockDelegator.new array
    delegator.expect :push, [1, 2], [Fixnum]
    assert_equal [1, 2], delegator.push(2)
  end

  def test_verify_returns_true_when_methods_are_called_as_expected
    array = Array.new
    delegator = MockDelegator.new array
    delegator.expect :push, [1, 2], [Fixnum]
    delegator.push 2
    assert delegator.verify
  end

  def test_verify_raises_when_methods_are_not_called_as_expected
    array = Array.new
    delegator = MockDelegator.new array
    delegator.expect :push, [1, 2], [Fixnum]
    assert_raises(MockExpectationError) { delegator.verify }
  end

  def test_raises_when_methods_are_called_with_wrong_number_of_arguments
    delegator = MockDelegator.new Object.new
    delegator.expect :test, true, [Object, Object]
    assert_raises(MockExpectationError) { delegator.test Object.new }
  end

  def test_raises_when_methods_are_called_with_wrong_argument_types
    delegator = MockDelegator.new Object.new
    delegator.expect :test, true, [Fixnum]
    assert_raises(MockExpectationError) { delegator.test String.new }
  end

  def test_missing_method_is_forwarded_to_delegate
    array = Array.new
    delegator = MockDelegator.new array
    assert delegator.respond_to?(:push)
    assert_equal [1], delegator.push(1)
  end
end
