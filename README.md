# SimpleMock

[![Build Status](https://secure.travis-ci.org/tatey/simple_mock.png?branch=master)](http://travis-ci.org/tatey/simple_mock)

A fast, tiny (81 lines) hybrid mocking library. Mix classical mocking with real objects. There's no monkey patching `Object` or copying objects. Real objects are completely untainted. The interface is 100% compatible with [MiniTest::Mock](https://github.com/seattlerb/minitest) so there is nothing new to learn. SimpleMock's one and only dependancy is Ruby 1.9.2 or greater.

## Installation

Add this to your project's Gemfile and run `$ bundle`.

``` ruby
gem 'simple_mock', :group => :test
```

SimpleMock is isolated so there is no need to set require to false.

## Usage

### Classical Mocking

A new SimpleMock object behaves identically to MiniTest::Mock.

``` ruby
mock_model = SimpleMock.new
mock_model.expect :valid?, true

mock_model.valid? # => true

mock_model.verify # => true
```

### Hybrid Mocking

Pass an object to mix expectations with the real object's original behaviour.

``` ruby
real_model = Post.new
mock_model = SimpleMock.new real_model
mock_model.expect :valid?, true

mock_model.valid? # => true
mock_model.create # => true

mock_model.verify # => true
```

This is done with delegation, avoiding monkey patching and copying. The real object is completely untainted.

``` ruby
mock_model.valid  # => true
real_model.valid? # => false

real_model.object_id == mock_model.__getobj__.object_id # => true
```

More documentation is available at [rubydoc.info](http://rubydoc.info/gems/simple_mock/frames).

## Caveats

Like MiniTest::Mock, `#expect` and `#verify` are reserved methods. Expectations should not be defined on real objects which implement these methods. As an alternative, consider creating an anonymous class which inherits from SimpleDelegator.

``` ruby
mock_class = Class.new SimpleDelegator do
  def verify *args
    true
  end
end
mock_instance = mock_class.new MyRealClass.new
mock_instance.verify # => true
```

SimpleMock does something similar to this under the hood.

## Copyright

Copyright © 2012 Tate Johnson. SimpleMock is released under the MIT license. See LICENSE for details.
