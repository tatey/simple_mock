# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_mock/version"

Gem::Specification.new do |s|
  s.name        = "simple_mock"
  s.version     = SimpleMock::VERSION
  s.authors     = ["Tate Johnson"]
  s.email       = ["tate@tatey.com"]
  s.homepage    = 'https://github.com/tatey/simple_mock'
  s.summary     = %q{A fast, tiny hybrid mocking library.}
  s.description = %q{A fast, tiny hybrid mocking library. Mix classical mocking with real objects. There's no monkey patching `Object` or copying objects. Real objects are completely untainted.}

  s.rubyforge_project = "simple_mock"

  s.required_ruby_version = '>= 1.9.2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
end
