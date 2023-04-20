Feature:
  In order to easily generate factory files instead of fixture files when generating models
  As a user of Rails and Factory Bot
  I would like to use factory_bot_rails generators.

  Background:
    Given I create a new rails application
    And I add "factory_bot_rails" from this project as a dependency
    And I run `bundle install` with a clean environment

  Scenario: The factory_bot_rails generators create a factory file for each model if there is not a factories.rb file
    When I run `bundle exec rails generate model User name:string age:integer` with a clean environment
    And I run `bundle exec rails generate model Namespaced::User name:string` with a clean environment
    Then the output should contain "test/factories/users.rb"
    And the output should contain "test/factories/namespaced/users.rb"
    And the file "test/factories/users.rb" should contain exactly:
      """
      FactoryBot.define do
        factory :user do
          name { "MyString" }
          age { 1 }
        end
      end
      """
    And the file "test/factories/namespaced/users.rb" should contain "factory :namespaced_user, class: 'Namespaced::User' do"

  Scenario: The factory_bot_rails generators create a factory file with correct naming when I use --force-plural
    When I run `bundle exec rails generate model UserMedia filename:string --force-plural` with a clean environment
    Then the output should contain "test/factories/user_media.rb"
    And the file "test/factories/user_media.rb" should contain exactly:
      """
      FactoryBot.define do
        factory :user_media do
          filename { "MyString" }
        end
      end
      """

  Scenario: The factory_bot_rails generators add a factory in the correct spot
    When I write to "test/factories.rb" with:
      """
      FactoryBot.define do
      end
      """
    And I run `bundle exec rails generate model User name:string` with a clean environment
    And I run `bundle exec rails generate model Robot name:string` with a clean environment
    Then the file "test/factories.rb" should contain exactly:
      """
      FactoryBot.define do
        factory :robot do
          name { "MyString" }
        end

        factory :user do
          name { "MyString" }
        end

      end
      """

  Scenario: The factory_bot_rails generators does not create a factory file for each model if there is a factories.rb file in the test directory
    When I write to "test/factories.rb" with:
      """
      FactoryBot.define do
      end
      """
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the file "test/factories/users.rb" should not contain "factory :user do"

  Scenario: The factory_bot_rails generators use a custom template
    When I write to "lib/templates/factory_bot/model/factories.erb" with:
      """
      <%= "Custom factory definition" %>
      """
    And I run `bundle exec rails generate model User` with a clean environment
    Then the file "test/factories/users.rb" should contain exactly:
      """
      Custom factory definition
      """

  Scenario: The factory_bot_rails generator can be disabled
    When I append to "config/application.rb" with:
      """
      Rails.application.configure do
        config.generators do |g|
          g.factory_bot false
        end
      end
      """
    And I run `bundle exec rails generate model User name:string age:integer` with a clean environment
    Then the output should not contain "test/factories/users.rb"
    And the output should contain "test/fixtures/users.yml"
