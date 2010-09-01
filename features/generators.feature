Feature:
  In order to easily generate factory files instead of fixture files when generating models
  As a user of Rails3 and factory_girl
  I would like to use factory_girl_rails generators.

  Scenario: The factory_girl_rails generators create a factory file
  for each model that I generate
    Given I run "rails new test_app"
    And I cd to "test_app"
    And a file named "Gemfile" with:
    """
    source "http://rubygems.org"
    gem 'rails', '3.0.0'
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'factory_girl_rails', :path => '../../../'
    """
    And I run "bundle install"
    And I run "rails generate model User name:string --fixture-replacement=factory_girl"
    And a file named "test/unit/user_test.rb" with:
    """
    require 'test_helper'

    class UserTest < ActiveSupport::TestCase
      test "use factory" do
        user = Factory(:user)
        assert_equal 'MyString', user.name
      end
    end
    """
    And I run "rake db:migrate"
    When I run "rake test"
    Then the output should contain "1 tests, 1 assertions, 0 failures, 0 errors"