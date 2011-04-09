# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ahn-rails/version"

Gem::Specification.new do |s|
  s.name        = "ahn-rails"
  s.version     = AhnRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Langfeld"]
  s.email       = %w{ben@langfeld.me}
  s.homepage    = "http://benlangfeld.github.com/ahn-rails"
  s.summary     = %q{Adhearsion helpers for Ruby on Rails}
  s.description = %q{Stretch rails beyond the browser, easily}

  s.rubyforge_project = "ahn-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'adhearsion', '~> 1.0.1'

  s.add_development_dependency 'rspec-rails', '~> 2.5.0'
  s.add_development_dependency 'cucumber', '~> 0.10.2'
  s.add_development_dependency 'aruba', '~> 0.3.5'
  s.add_development_dependency 'rails', '~> 3.0.6'
  s.add_development_dependency 'mocha', '~> 0.9.12'
  s.add_development_dependency 'bcrypt-ruby', '~> 2.1.2'
  s.add_development_dependency 'sqlite3-ruby', '~> 1.3.1'
  s.add_development_dependency 'capistrano'
end
