factory_girl [![Build Status](https://secure.travis-ci.org/thoughtbot/factory_girl_rails.png)](http://travis-ci.org/thoughtbot/factory_girl_rails?branch=master)
============

factory_girl is a fixtures replacement with a straightforward definition
syntax, support for multiple build strategies (saved instances, unsaved
instances, attribute hashes, and stubbed objects), and support for multiple
factories for the same class (user, admin_user, and so on), including factory
inheritance.

Rails
-----

factory_girl_rails provides Rails integration for factory_girl. All
Rails-specific features are only compatible with Rails 3.

Currently, automatic factory definition loading is the only Rails-specific feature.

Download
--------

Github: http://github.com/thoughtbot/factory_girl_rails/tree/master

Gem:

    gem install factory_girl_rails

Configuration
-------------

Add factory_girl_rails to your Gemfile:

    gem 'factory_girl_rails'

Optionally, to have rails generators automatically generate factories instead
of fixtures, add the following to your application.rb file:

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end

`fixture_replacement :factory_girl` takes an option `:suffix => 'some_suffix'`
to generate factories as "modelname_some_suffix.rb"

Cucumber Integration
--------------------

factory_girl ships with step definitions for Cucumber integration. For more information, see the GETTING_STARTED file in the factory_girl repo.


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

factory_girl is Copyright © 2008-2012 Joe Ferris and thoughtbot. It is free software, and may be redistributed under the terms specified in the LICENSE file.
