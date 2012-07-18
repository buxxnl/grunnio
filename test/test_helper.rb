ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/rails"
require 'minitest/autorun'
require "minitest/rails/capybara"
# Uncomment if you want awesome colorful output
require "minitest/pride"
require 'miniskirt'
require "factories" # If you define your factories in test/factories.rb
require 'mocha'
require 'turn'

class MiniTest::Rails::ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

MiniTest::Rails.override_testunit!

# Support files
# Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
#   require file
# end


Turn.config do |c|
  # use one of output formats:
  # :outline  - turn's original case/test outline mode [default]
  # :progress - indicates progress with progress bar
  # :dotted   - test/unit's traditional dot-progress mode
  # :pretty   - new pretty reporter
  # :marshal  - dump output as YAML (normal run mode only)
  # :cue      - interactive testing
  c.format  = :cue
  # turn on invoke/execute tracing, enable full backtrace
  c.trace   = true
  # use humanized test names (works only with :outline format)
  c.natural = true
end
