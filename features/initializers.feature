Feature: properly integrate with Rails and other gems

  Background:
    When I create a new rails application
    And I add "factory_bot_rails" from this project as a dependency
    And I run `bundle install` with a clean environment

  Scenario: handle already loaded ActiveRecord::Base by another gems earlier
    When I run the following commands:
      """bash
      cat config/application.rb
      sed -i -e '/require "rails\/test_unit\/railtie"/a\'$'\n''require "active_record/base"' config/application.rb
      """
    When I run `bundle exec rake test` with a clean environment
    Then the output should contain "0 runs"
