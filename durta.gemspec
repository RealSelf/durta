# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'durta/version'

Gem::Specification.new do |spec|
  spec.name          = "durta"
  spec.version       = Durta::VERSION
  spec.authors       = ["Sam Leavens"]
  spec.email         = ["sam@realself.com"]
  spec.description   = %q{Simple gem for recording and reporting metrics}
  spec.summary       = %q{Simple gem for recording and reporting metrics}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
