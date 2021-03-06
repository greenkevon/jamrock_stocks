# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jamrock_stocks/version'

Gem::Specification.new do |spec|
  spec.name          = "jamrock_stocks"
  spec.version       = JamrockStocks::VERSION
  spec.authors       = ["Kevon Green"]
  spec.email         = ["admin@solidappsfarm.com"]
  spec.summary       = %q{Fetch Jamaican Stocks}
  spec.description   = %q{Retrieves a list of Jamaican stocks at a point in time}
  spec.homepage      = "http://www.solidappsfarm.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
