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
end
