# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quintype/api/version'

Gem::Specification.new do |spec|
  spec.name          = "quintype-seo-ruby"
  spec.version       = Quintype::Seo::VERSION
  spec.authors       = ["Ramsharan"]
  spec.email         = ["sharangj@gmail.com"]

  spec.summary       = %q{Ruby Gem to set seo meta tags for quintype}
  spec.homepage      = "https://github.com/quintype/quintype-seo-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
