# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redis-rails/version"

Gem::Specification.new do |s|
  s.name        = "redis-rails"
  s.version     = Redis::Rails::VERSION
  s.authors     = ["Luca Guidi"]
  s.email       = ["guidi.luca@gmail.com"]
  s.homepage    = "http://jodosha.github.com/redis-store"
  s.summary     = %q{Redis for Ruby on Rails}
  s.description = %q{Redis for Ruby on Rails}

  s.rubyforge_project = "redis-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
