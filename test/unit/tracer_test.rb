require 'helper'

class TracerTest < MiniTest::Unit::TestCase
  def setup
    @tracer = Tracer.new
  end

  def test_register_stores_expected_method_and_arguments
    @tracer.register :plus_one, [Fixnum]
    assert_equal [Fixnum], @tracer.expected_calls[:plus_one]
  end

  def test_assert_returns_true_when_methods_are_called_as_expected
    @tracer.register :plus_one, [Fixnum]
    assert @tracer.assert(:plus_one, [1])
    assert @tracer.actual_calls[:plus_one]
  end

  def test_assert_raises_when_methods_are_called_with_wrong_number_of_arguments
    @tracer.register :plus_one, [Fixnum, Fixnum]
    e = assert_raises(ArgumentError) { @tracer.assert :plus_one, [1] }
    assert_equal 'mocked method :plus_one expects 2 arguments, got 1', e.message
  end

  def test_assert_raises_when_methods_are_called_with_wrong_arguments
    @tracer.register :plus_one, [Fixnum]
    e = assert_raises(MockExpectationError) { @tracer.assert :plus_one, [String.new] }
    assert_equal 'mocked method :plus_one called with unexpected arguments [""]', e.message
  end

  def test_verify_returns_true_when_methods_are_called_as_expected
    @tracer.expected_calls = {:plus_one => [Fixnum]}
    @tracer.actual_calls   = {:plus_one => true}
    assert @tracer.verify
  end

  def test_verify_raises_when_expected_methods_are_not_called
    @tracer.expected_calls = {:plus_one => [Fixnum]}
    @tracer.actual_calls   = {:plus_two => true}
    e = assert_raises(MockExpectationError) { @tracer.verify }
    assert_equal 'expected :plus_one', e.message
  end
end
