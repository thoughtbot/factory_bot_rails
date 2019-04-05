Feature:
  When using factory_bot_rails together with Spring
  I want changes to my application to trigger the factory_bot_rails reloader
  So that factory_bot_rails doesn't hold onto stale class references

  Scenario: Editing a model without editing the factory
    When I successfully run `bundle exec rails new testapp -m ../../features/support/rails_template`
    And I cd to "testapp"
    And I add "factory_bot_rails" from this project as a dependency
    And I add "test-unit" as a dependency
    And I run `bundle install` with a clean environment
    And I write to "db/migrate/1_create_users.rb" with:
      """
      migration_class =
        if ActiveRecord::Migration.respond_to?(:[])
          ActiveRecord::Migration[4.2]
        else
          ActiveRecord::Migration
        end

      class CreateUsers < migration_class
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
      """
    And I run `bundle exec rake db:migrate` with a clean environment
    And I write to "app/models/user.rb" with:
      """
      class User < ActiveRecord::Base
      end
      """
    And I write to "test/factories.rb" with:
      """
      FactoryBot.define do
        factory :author, class: User do
          name { "Frank" }
        end
      end
      """
    And I write to "test/unit/user_test.rb" with:
      """
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        test "use factory" do
          author = FactoryBot.create(:author)

          assert_equal author.class.object_id, User.object_id
        end
      end
      """
    And I run `bundle binstubs bundler rake spring --force` with a clean environment
    And I run `bin/spring binstub --all` with a clean environment
    And I run `bin/rake test` with Spring enabled
    And I append to "app/models/user.rb" with:
      """
      # User model edited
      """
    And I run `bin/rake test` with Spring enabled
    And I run `spring stop` with a clean environment
    Then the output should contain "1 runs, 1 assertions"
    And the output should not contain "Failure:"
