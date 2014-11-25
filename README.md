# factory_girl_rails [![Build Status][ci-image]][ci] [![Code Climate][grade-image]][grade]

[factory_girl][fg] is a fixtures replacement with a straightforward definition
syntax, support for multiple build strategies (saved instances, unsaved
instances, attribute hashes, and stubbed objects), and support for multiple
factories for the same class (`user`, `admin_user`, and so on), including factory
inheritance.

## Rails

factory_girl_rails provides Rails integration for [factory_girl][fg].

Currently, automatic factory definition loading is the only Rails-specific feature.

Supported Rails versions are listed in [`Appraisals`](Appraisals). Supported
Ruby versions are listed in [`.travis.yml`](.travis.yml).

## Download

Github: http://github.com/thoughtbot/factory_girl_rails

Gem:

    gem install factory_girl_rails

## Configuration

Add `factory_girl_rails` to your Gemfile:

```ruby
gem 'factory_girl_rails'
```

Generators for factories will automatically substitute fixture (and maybe any other
`fixture_replacement` you set). If you want to disable this feature, add the
following to your application.rb file:

```ruby
config.generators do |g|
  g.factory_girl false
end
```

Default factories directory is `test/factories`, or `spec/factories` if
`test_framework` generator is set to `:rspec`; change this behavior with:

```ruby
config.generators do |g|
  g.factory_girl dir: 'custom/dir/for/factories'
end
```

If you use factory_girl for fixture replacement, ensure that
factory_girl_rails is available in the development group. If it's not, Rails
will generate standard .yml files instead of factory files.

factory_girl takes an option `suffix: 'some_suffix'` to generate factories as
`modelname_some_suffix.rb`.

If you use factory_girl for fixture replacement and already have a
`factories.rb` file in the directory that contains your tests,
factory_girl_rails will insert new factory definitions at the top of
`factories.rb`.

## Engines

If FactoryGirl is used in a Rails Engine, it may be nice to make the
factories available to the application using the engine.
To do that, include the lines below in the Engine class

```ruby
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end
```

If you had a non-automatic way to load factories, you must remove that.
The above code will load the factories also in a dummy or test app
while testing the engine, and you will get duplication errors otherwise.

Also, if the Engine is a gem, make sure you add the spec/factories directory
to the gem files (not test_files).

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Credits

[factory_girl][fg] was originally written by Joe Ferris.

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

factory_girl is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

## License

factory_girl_rails is Copyright © 2008-2014 Joe Ferris and thoughtbot. It is free
software, and may be redistributed under the terms specified in the
[LICENSE]() file.

[fg]: https://github.com/thoughtbot/factory_girl
[ci]: http://travis-ci.org/thoughtbot/factory_girl_rails?branch=master
[ci-image]: https://secure.travis-ci.org/thoughtbot/factory_girl_rails.png
[grade]: https://codeclimate.com/github/thoughtbot/factory_girl_rails
[grade-image]: https://codeclimate.com/github/thoughtbot/factory_girl_rails.png
