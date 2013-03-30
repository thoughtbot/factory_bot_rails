# factory_girl_rails [![Gem Version](https://badge.fury.io/rb/factory_girl_rails.png)](http://badge.fury.io/rb/factory_girl_rails) [![Build Status](https://secure.travis-ci.org/thoughtbot/factory_girl_rails.png)](http://travis-ci.org/thoughtbot/factory_girl_rails?branch=master) [![Dependency Status](https://gemnasium.com/thoughtbot/factory_girl_rails.png)](https://gemnasium.com/thoughtbot/factory_girl_rails)

[`factory_girl`](https://github.com/thoughtbot/factory_girl) is a fixtures replacement with a straightforward definition
syntax, support for multiple build strategies (saved instances, unsaved
instances, attribute hashes, and stubbed objects), and support for multiple
factories for the same class (`user`, `admin_user`, and so on), including factory
inheritance.

## Rails
`factory_girl_rails` provides Rails integration for `factory_girl`. All
Rails-specific features are only compatible with Rails 3.

Currently, automatic factory definition loading is the only Rails-specific feature.

## Download
Github: http://github.com/thoughtbot/factory_girl_rails/tree/master

## Installation

Using [RubyGems](https://github.com/rubygems/rubygems):

`gem install factory_girl_rails`

Using [Bundler](https://github.com/carlhuda/bundler), inside of your `Gemfile`:

```ruby
group :development, :test do
  gem 'factory_girl_rails'
end
```

## Configuration

With the gem inside both `:development` and `:test` groups, Factory Girl will 
automatically become your fixture replacement when using rails generators. By default, 
Rails will attempt to create your factories inside of `spec/factories`.

To change this default, if you're using RSpec as your test framework for instance, 
add the following to your `config/application.rb`:

```ruby
config.generators do |g|
  g.test_framework :rspec
end
```

This gem will automatically detect this configuration and tell Rails to create 
factories in `spec/factories` instead. 

Alternatively, you can manually set this using:

```ruby
config.generators do |g|
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
end
```

By default, factories will be named `model_name.rb`, but if you prefer `model_name_factory.rb` 
your can use the `:suffix` option: 

```ruby
config.generators do |g|
  g.fixture_replacement :factory_girl, :suffix => 'factory'
end
```

## More Information

factory_girl: http://github.com/thoughtbot/factory_girl/tree/master


## Contributing

Please see [CONTRIBUTING.md]() for details.

## Credits

factory_girl was originally written by Joe Ferris.

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

factory_girl is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

## License

factory_girl is Copyright © 2008-2013 Joe Ferris and thoughtbot. It is free software, and may be redistributed under the terms specified in the LICENSE file.
