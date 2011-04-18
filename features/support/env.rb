require 'cucumber'
require 'rspec'
require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 30
end
