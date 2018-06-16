Feature: automatically load step definitions

  Background:
    When I successfully run `bundle exec rails new testapp`
    And I cd to "testapp"
    And I add "factory_bot_rails" from this project as a dependency
    And I add "test-unit" as a dependency
    And I run `bundle install` with a clean environment
    And I write to "db/migrate/1_create_users.rb" with:
      """
      class CreateUsers < ActiveRecord::Migration
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
      """
    When I run `bundle exec rake db:migrate` with a clean environment
    And I write to "app/models/user.rb" with:
      """
      class User < ActiveRecord::Base
      end
      """

  Scenario: generate a Rails application and use factory definitions
    When I write to "test/factories.rb" with:
      """
      FactoryBot.define do
        factory :user do
          name "Frank"
        end
      end
      """
    When I write to "test/unit/user_test.rb" with:
      """
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        test "use factory" do
          user = FactoryBot.create(:user)
          assert_equal 'Frank', user.name
        end
      end
      """
    When I run `bundle exec rake test` with a clean environment
    Then the output should contain "1 assertions, 0 failures, 0 errors"

  Scenario: use factories advertised by railties/engines/3rd-party gems
    When I append to "config/application.rb" with:
      """
        require File.expand_path('../../lib/some_railtie/railties.rb', __FILE__)
      """
    When I write to "lib/some_railtie/railties.rb" with:
      """
      module SomeRailtie
        class Railtie < ::Rails::Engine

          initializer "some_railtie.factories", :after => "factory_bot.set_factory_paths" do
            FactoryBot.definition_file_paths << File.expand_path('../factories', __FILE__)
          end
        end
      end
      """
    When I write to "lib/some_railtie/factories.rb" with:
      """
      FactoryBot.define do
        factory :factory_from_some_railtie, class: 'User' do
          name 'Artem'
        end
      end
      """
    When I write to "test/unit/user_test.rb" with:
      """
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        test "use factory of some_railtie" do
          user = FactoryBot.create(:factory_from_some_railtie)
          assert_equal 'Artem', user.name
        end
      end
      """
    When I run `bundle exec rake test` with a clean environment
    Then the output should contain "1 assertions, 0 failures, 0 errors"
