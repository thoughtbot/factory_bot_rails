Feature: automatically reloading factory_bot definitions
  Background:
    When I create a new rails application
    And I add "factory_bot_rails" from this project as a dependency
    And I run `bundle install` with a clean environment
    And I write to "db/migrate/1_create_users.rb" with:
      """
      class CreateUsers < ActiveRecord::Migration[5.0]
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
      """
    And I run `bin/rails db:migrate` with a clean environment

  Scenario: When using factory_bot_rails together with Spring
    I want changes to my application to trigger the factory_bot_rails reloader
    So that factory_bot_rails doesn't hold onto stale class references

    When I write to "app/models/user.rb" with:
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
        test "user factory" do
          author = FactoryBot.create(:author)

          assert_equal author.class.object_id, User.object_id
        end
      end
      """
    # # And I run `bundle binstubs bundler spring --force` with a clean environment
    # And I run `bundle exec spring binstub --all` with a clean environment
    And I run `bin/rails test` with Spring enabled
    And I append to "app/models/user.rb" with:
      """
      # User model edited
      """
    And I run `bin/rails test` with Spring enabled
    And I run `bundle exec spring stop` with a clean environment
    # And I run `bin/spring stop` with a clean environment
    Then the output should contain "1 runs, 1 assertions"
    And the output should not contain "Failure:"

  Scenario: When using factory_bot_rails together with Spring
    I want changes to my factory_bot definitions to trigger a reload
    So that I can use my updated definitions without stopping spring

    When I write to "app/models/user.rb" with:
      """
      class User < ActiveRecord::Base
      end
      """
    And I write to "test/factories.rb" with:
      """
      # Empty definition file to be picked up by the file watcher

      """
    # And I run `bundle binstubs bundler spring --force` with a clean environment
    # And I run `bin/spring binstub --all` with a clean environment
    And I run `bin/rails test` with Spring enabled
    And I append to "test/factories.rb" with:
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
        test "user factory" do
          author = FactoryBot.create(:author)

          assert_equal author.class.object_id, User.object_id
        end
      end
      """
    And I run `bin/rails test` with Spring enabled
    # And I run `bin/spring stop` with a clean environment
    And I run `bundle exec spring stop` with a clean environment
    Then the output should contain "1 runs, 1 assertions"
    And the output should not contain "Failure:"

  Scenario: Initializing the reloader with I18n support
      When I write to "app/models/user.rb" with:
        """
        class User
          TRANSLATION = I18n.translate("translation_key")
        end
        """
      And I write to "config/locales/en.yml" with:
        """
          en:
            translation_key: "translation_value"
        """
      And I write to "test/factories.rb" with:
        """
        FactoryBot.define do
          factory :user do
            User::TRANSLATION
          end
        end
        """
      And I write to "test/unit/user_test.rb" with:
        """
        require 'test_helper'

        class UserTest < ActiveSupport::TestCase
          test "eser factory" do
            user = FactoryBot.build(:user)

            assert_equal "translation_value", User::TRANSLATION
          end
        end
        """
      And I run `bin/rails test` with a clean environment
      Then the output should contain "1 runs, 1 assertions"
      And the output should not contain "Failure:"
