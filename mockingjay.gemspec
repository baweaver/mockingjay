# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mockingjay/version'

Gem::Specification.new do |spec|
  spec.name          = "mockingjay"
  spec.version       = Mockingjay::VERSION
  spec.authors       = ["Brandon Weaver"]
  spec.email         = ["keystonelemur@gmail.com"]
  spec.summary       = %q{Dynamic Fixture Creation}
  spec.description   = %q{Let your data define your fixtures for you}
  spec.homepage      = "https://github.com/baweaver/mockingjay"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "faker"
  spec.add_runtime_dependency "json"
end
