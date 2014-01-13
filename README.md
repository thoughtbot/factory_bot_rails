factory_girl [![Build Status](https://secure.travis-ci.org/thoughtbot/factory_girl_rails.png)](http://travis-ci.org/thoughtbot/factory_girl_rails?branch=master)
============

`factory_girl` is a fixtures replacement with a straightforward definition
syntax, support for multiple build strategies (saved instances, unsaved
instances, attribute hashes, and stubbed objects), and support for multiple
factories for the same class (`user`, `admin_user`, and so on), including factory
inheritance.

Rails
-----

`factory_girl_rails` provides Rails integration for `factory_girl`. All
Rails-specific features are only compatible with Rails 3.

Currently, automatic factory definition loading is the only Rails-specific feature.

Download
--------

Github: http://github.com/thoughtbot/factory_girl_rails/tree/master

Gem:

    gem install factory_girl_rails

Configuration
-------------

Add `factory_girl_rails` to your Gemfile:

    gem 'factory_girl_rails'

Generators for factories will automatically substitute fixture (and maybe any other
`fixture_replacement` you set). If you want to disable this feature, add the
following to your application.rb file:

    config.generators do |g|
      g.factory_girl false
    end

Default factories directory is `test/factories`, or `spec/factories` if
`test_framework` generator is set to `:rspec`; change this behavior with:

    config.generators do |g|
      g.factory_girl dir: 'custom/dir/for/factories'
    end

If you use `factory_girl` for fixture replacement, ensure that
`factory_girl_rails` is available in the development group. If it's not, Rails
will generate standard yml files instead of factory files.

`factory_girl` takes an option `suffix: 'some_suffix'`
to generate factories as "modelname_some_suffix.rb"

More Information
----------------

factory_girl: http://github.com/thoughtbot/factory_girl/tree/master


Contributing
------------

Please see CONTRIBUTING.md for details.

Credits
-------

factory_girl was originally written by Joe Ferris.

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

factory_girl is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

License
-------

factory_girl is Copyright © 2008-2013 Joe Ferris and thoughtbot. It is free software, and may be redistributed under the terms specified in the LICENSE file.
