Feature:
  In order to easily generate factory files instead of fixture files when generating models
  As a user of Rails3 and factory_girl
  I would like to use factory_girl_rails generators.

  Background:
    Given I successfully run `bundle exec rails new testapp`
    And I cd to "testapp"
    And I add "factory_girl_rails" from this project as a dependency

  Scenario: The factory_girl_rails generators create a factory file for each model that I generate
    When I run `bundle install` with a clean environment
    And I run `bundle exec rails generate model User name:string --fixture-replacement=factory_girl` with a clean environment
    And I run `bundle exec rails generate model Namespaced::User name:string --fixture-replacement=factory_girl` with a clean environment
    Then the output should contain "test/factories/users.rb"
    And the output should contain "test/factories/namespaced_users.rb"
    And the file "test/factories/users.rb" should contain "factory :user do"
    And the file "test/factories/namespaced_users.rb" should contain "factory :namespaced_user, :class => 'Namespaced::User' do"

  Scenario: The factory_girl_rails generators create a factory file with a custom name for each model that I generate
    When I run `bundle install` with a clean environment
    And I set the FactoryGirl :suffix option to "factory"
    And I run `bundle exec rails generate model User name:string --fixture-replacement=factory_girl` with a clean environment
    And I run `bundle exec rails generate model Namespaced::User name:string --fixture-replacement=factory_girl` with a clean environment
    Then the output should contain "test/factories/users_factory.rb"
    And the output should contain "test/factories/namespaced_users_factory.rb"
    And the file "test/factories/users_factory.rb" should contain "factory :user do"
    And the file "test/factories/namespaced_users_factory.rb" should contain "factory :namespaced_user, :class => 'Namespaced::User' do"

  Scenario: The factory_girl_rails generators create a factory file using configured suffix with RSpec for each model that I generate
    When I add "rspec-rails" as a dependency
    And I configure the factories as:
      """
      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_girl, suffix: 'factory'
      end
      """
    And I run `bundle install` with a clean environment
    Then the output should contain "rspec-rails"
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should exist:
      | spec/factories/users_factory.rb |
