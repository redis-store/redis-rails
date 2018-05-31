# Redis stores for Ruby on Rails

__`redis-rails`__ provides a full set of stores (*Cache*, *Session*, *HTTP Cache*) for __Ruby on Rails__. See the main [redis-store readme](https://github.com/redis-store/redis-store) for general guidelines.

## A quick note about Rails 5.2

Rails 5.2.0 [includes a Redis cache store out of the
box](https://github.com/rails/rails/pull/31134), so you don't really
need this gem anymore if you just need to store the fragment cache in
Redis. Maintenence on the [redis-activesupport](https://github.com/redis-store/redis-activesupport) 
gem will continue for security and compatibility issues, but we are no longer accepting new
features. We are still actively maintaining all other gems in the redis-store
family.

## Installation

Add the following to your Gemfile:

```ruby
gem 'redis-rails'
```

## Usage

```ruby
# config/application.rb
config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }
```

(**NOTE:** The `:expires_in` option can also be written as `:expire_in` and `:expire_after`)

To be fault tolerant when redis is not available you can set option `raise_errors` to `false` since `redis-activesupport` [v4.1.4](https://github.com/redis-store/redis-activesupport/commit/d299520fde0aebfa24801f60ebe40a3973fc3164).

Configuration values at the end are optional. If you want to use Redis as a backend for sessions, you will also need to set:

```ruby
# config/initializers/session_store.rb
MyApplication::Application.config.session_store :redis_store, servers: ["redis://localhost:6379/0/session"]
```

You can also provide a hash instead of a URL

```ruby
config.cache_store = :redis_store, {
  host: "localhost",
  port: 6379,
  db: 0,
  password: "mysecret",
  namespace: "cache"
}
```

And similarly for the session store:

```ruby
MyApplication::Application.config.session_store :redis_store, {
  servers: [
    {
      host: "localhost",
      port: 6379,
      db: 0,
      password: "mysecret",
      namespace: "session"
    },
  ],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.parent_name.downcase}_session"
}
```
(**NOTE:** You can not write `:expires_in` or `:expire_in`as a substitute for `:expire_after`.)

For Rails default CookieStore, we use `:expire_after`.

Both CookieStore and RedisStore inherits Rack::Session::Abstract::Persisted.
It has `:expire_after` option but not `:expires_in`.

NOTE: The sessions store uses a global lock to ensure operations are atomic. No atomic guarantees can be made if you're running multiple instances of your app, so it is recommended that you disable this by using the `threadsafe: false` option.

And if you would like to use Redis as a rack-cache backend for HTTP caching, add [`redis-rack-cache`](https://github.com/redis-store/redis-rack-cache) to your Gemfile and add:

```ruby
# config/environments/production.rb
config.action_dispatch.rack_cache = {
  metastore: "redis://localhost:6379/1/metastore",
  entitystore: "redis://localhost:6379/1/entitystore"
}
```

## Usage with Redis Sentinel

```ruby
sentinel_config = {
  url: "redis://mymaster/0",
  role: "master",
  sentinels: [{
    host: "127.0.0.1",
    port: 26379
  },{
    host: "127.0.0.1",
    port: 26380
  },{
    host: "127.0.0.1",
    port: 26381
  }]
}

# configure cache, merging opts with sentinel conf
config.cache_store = :redis_store, sentinel_config.merge(
  namespace: "cache",
  expires_in: 1.days
)

# configure sessions, setting the sentinel config as the
# servers value, merging opts with the sentinel conf.
config.session_store :redis_store, {
  servers: [
    sentinel_config.merge(
      namespace: "sessions"
    )
  ],
  expire_after: 2.days
}
```

## Usage with Redis Cluster

Although there isn't an official redis cluster client for ruby, many teams use a redis cluster proxy. Often, redis cluster proxies do not support the `MULTI` command which might contain keys belonging to different masters. To get around this problem, you can use the `avoid_multi_commands: true` option. This will tell redis store to use the redis gem's `pipelined` feature instead of a `MULTI` command. You should only use this if your redis cluster proxy fails to process `MULTI` commands.

## Running tests

```shell
gem install bundler
git clone git://github.com/redis-store/redis-rails.git
cd redis-rails
RAILS_VERSION=5.0.1 bundle install
RAILS_VERSION=5.0.1 bundle exec rake
```

If you are on **Snow Leopard** you have to run `env ARCHFLAGS="-arch x86_64" bundle exec rake`

## Status

[![Gem Version](https://badge.fury.io/rb/redis-rails.svg)](http://badge.fury.io/rb/redis-rails)
[![Build Status](https://secure.travis-ci.org/redis-store/redis-rails.svg?branch=master)](http://travis-ci.org/redis-store/redis-rails?branch=master)
[![Code Climate](https://codeclimate.com/github/redis-store/redis-rails.svg)](https://codeclimate.com/github/redis-store/redis-rails)

## Copyright

2009 - 2011 Luca Guidi - [http://lucaguidi.com](http://lucaguidi.com), released under the MIT license
