# -*- encoding: utf-8 -*-

require_relative "lib/redis-rails/version"

Gem::Specification.new do |s|
  s.name        = "redis-rails"
  s.version     = Redis::Rails::VERSION
  s.authors     = ["Luca Guidi", "Ryan Bigg"]
  s.email       = ["me@lucaguidi.com", "me@ryanbigg.com"]
  s.homepage    = "http://redis-store.org/redis-rails"
  s.summary     = %q{Redis for Ruby on Rails}
  s.description = %q{Redis for Ruby on Rails}
  s.license     = 'MIT'

  s.files = `git ls-files`.split("\n")

  s.add_dependency "redis-activesupport", [">= 3.0", "< 8"]
  s.add_dependency "redis-actionpack",    [">= 3.0", "< 8"]
end
