# Redis stores for Ruby on Rails

__`redis-rails`__ provides a full set of stores (*Cache*, *Session*, *HTTP Cache*) for __Ruby on Rails__. See the main [redis-store readme](https://github.com/redis-store/redis-store) for general guidelines.

## Installation

```ruby
# Gemfile
gem 'redis-rails' # Will install several other redis-* gems
```

## Usage

```ruby
# config/application.rb
config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
```

Configuration values at the end are optional. If you want to use Redis as a backend for sessions, you will also need to set. The `redis_server` option must be included if you are overriding the shown default:

```ruby
# config/initializers/session_store.rb
MyApplication::Application.config.session_store :redis_store, {
  redis_server: Redis::Store::Factory.resolve("redis://localhost:6379/0")
}
```


And if you would like to use Redis as a rack-cache backend for HTTP caching:

```ruby
# config/environments/production.rb
config.action_dispatch.rack_cache = {
  metastore:   'redis://localhost:6379/1/metastore',
  entitystore: 'redis://localhost:6379/1/entitystore'
}
```

## Running tests

```shell
gem install bundler
git clone git://github.com/redis-store/redis-rails.git
cd redis-rails
bundle install
bundle exec rake
```

If you are on **Snow Leopard** you have to run `env ARCHFLAGS="-arch x86_64" bundle exec rake`

## Status

[![Gem Version](https://badge.fury.io/rb/redis-rails.png)](http://badge.fury.io/rb/redis-rails) [![Build Status](https://secure.travis-ci.org/redis-store/redis-rails.png?branch=master)](http://travis-ci.org/jodosha/redis-rails?branch=master) [![Code Climate](https://codeclimate.com/github/jodosha/redis-store.png)](https://codeclimate.com/github/redis-store/redis-rails)

## Copyright

2009 - 2011 Luca Guidi - [http://lucaguidi.com](http://lucaguidi.com), released under the MIT license
