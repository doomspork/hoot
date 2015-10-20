# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hoot/version'

Gem::Specification.new do |spec|
  spec.name          = 'hoot'
  spec.version       = Hoot::VERSION
  spec.authors       = ['Sean Callan']
  spec.email         = ['sean@seancallan.com']
  spec.summary       = 'A simple condition based language.'
  spec.homepage      = 'http://seancallan.com'
  spec.license       = 'MIT'

  spec.files         = ['README.md'] + Dir['lib/**/*'] 
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'treetop',          '~> 1.5.3'
  spec.add_development_dependency 'bundler',      '~> 1.7'
  spec.add_development_dependency 'guard',        '~> 2.8.2'
  spec.add_development_dependency 'guard-rspec',  '~> 4.3.1'
  spec.add_development_dependency 'guard-spork',  '~> 2.0.1'
  spec.add_development_dependency 'pry',          '~> 0.10'
  spec.add_development_dependency 'pry-byebug',   '~> 2.0'
  spec.add_development_dependency 'rake',         '~> 10.0'
  spec.add_development_dependency 'rr',           '~> 1.1'
  spec.add_development_dependency 'rspec',        '~> 3.1'
  spec.add_development_dependency 'rspec-its',    '~> 1.0'
  spec.add_development_dependency 'simplecov',    '~> 0.9'
end
