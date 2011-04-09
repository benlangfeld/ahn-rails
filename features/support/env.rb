require 'cucumber'
require 'rspec'
require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 5
end
