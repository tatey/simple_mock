# SimpleMock

A fast, tiny mocking library that mixes expectations with real objects. There's no monkey patching or copying. Real objects are completely untainted. The interface is 100% compatible with MiniTest::Mock so there is nothing new to learn. SimpleMock's one and only dependancy is Ruby.

## Installation

TODO

## Usage

A new SimpleMock object behaves identically to MiniTest::Mock.

``` ruby
mock_model = SimpleMock.new
mock_model.expect :valid?, true

mock_model.valid? # => true

mock_model.verify # => true
```

...or pass an object to mix expectations with the real object's original behaviour.

``` ruby
real_model = Post.new
mock_model = SimpleMock.new real_model
mock_model.expect :valid?, false

mock_model.valid? # => true
mock_model.create # => true

mock_model.verify # => true
```

This is done with delegation, avoiding monkey patching and copying. The real object is completely untainted.

``` ruby
mock_model.valid  # => true
real_model.valid? # => false

real_model.object_id == mock_model.object_id # => true
```

## Examples

TODO

## Copyright

Copyright © 2012 Tate Johnson. SimpleMock is released under the MIT license. See LICENSE for details.
