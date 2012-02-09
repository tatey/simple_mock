# SimpleMock

A light weight mocking library with delegation. Inspired by this [blog post](http://tatey.com/2012/02/07/mocking-with-minitest-mock-and-simple-delegator/). I'm expecting the API to look something like this.

``` ruby
# Without an argument, SimpleMock behaves identically to MiniTest::Mock.new
mock = SimpleMock.new
mock.expect :valid?, false
mock.valid? # => false
mock.save   # => NoMethodError
mock.verify # => true

# With an argument, SimpleMock instantiates an anonymous class that inherits from SimpleDelegate.
# Except for expectations, all methods are forwarded to the delegate.
mock = SimpleMock.new Post.new
mock.expect :valid?, false
mock.valid? # => false
mock.save   # => false
mock.verify # => true
```

## Copyright

Copyright © 2012 Tate Johnson. Conformist is released under the MIT license. See LICENSE for details.
