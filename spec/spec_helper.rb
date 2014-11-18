require 'rubygems'
require 'spork'

Spork.prefork do
  ENV['RACK_ENV'] = 'test'

  require 'simplecov'
  require 'rspec/its'
  require 'rr'

  SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter]

  SimpleCov.start do
    add_filter 'spec'
    coverage_dir 'docs/coverage'
  end

  require 'hoot'

  Dir['spec/support/**/*.rb'].each { |f| require f }

  RSpec.configure do |config|
    config.pattern = '**/*_spec.rb'
    config.mock_framework = :rr
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
