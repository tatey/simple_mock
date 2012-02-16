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

  def test_expect_calls_register_on_tracer
    tracer = MiniTest::Mock.new
    tracer.expect :register, true, [Symbol, Array]
    delegator = MockDelegator.new Object.new
    delegator.__tracer = tracer
    delegator.expect :plus_one, 2
    assert tracer.verify
  end

  def test_verify_is_forwarded_to_tracer
    tracer = Class.new { define_method(:verify) { true } }.new
    delegator = MockDelegator.new Object.new
    delegator.__tracer = tracer
    assert_equal true, delegator.verify
  end

  def test_method_is_forwarded_to_delegate
    array = Array.new
    delegator = MockDelegator.new array
    assert delegator.respond_to?(:push)
    assert_equal [1], delegator.push(1)
  end

  def test_method_calls_assert_on_tracer
    tracer = MockDelegator.new Tracer.new
    tracer.expect :assert, true, [Symbol, Array]
    delegator = MockDelegator.new Object.new
    delegator.__tracer = tracer
    delegator.expect :plus_one, 2
    delegator.plus_one
    assert tracer.verify
  end
end
