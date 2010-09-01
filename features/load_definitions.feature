Feature: automatically load step definitions

  Scenario: generate a rails 3 application and use factory definitions
    Given I run "rails new test_app"
    And I cd to "test_app"
    And a file named "Gemfile" with:
      """
      source "http://rubygems.org"
      gem 'rails', '3.0.0'
      gem 'sqlite3-ruby', :require => 'sqlite3'
      gem 'factory_girl_rails', :path => '../../../'
      """
    And a file named "db/migrate/1_create_users.rb" with:
      """
      class CreateUsers < ActiveRecord::Migration
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
      """
    And a file named "app/models/user.rb" with:
      """
      class User < ActiveRecord::Base
      end
      """
    And a file named "test/factories.rb" with:
      """
      Factory.define :user do |user|
        user.name 'Frank'
      end
      """
    And a file named "test/unit/user_test.rb" with:
      """
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        test "use factory" do
          user = Factory(:user)
          assert_equal 'Frank', user.name
        end
      end
      """

    And I run "bundle install"
    And I run "rake db:migrate"
    And I run "rake test"
    Then the output should contain "1 tests, 1 assertions, 0 failures, 0 errors"
