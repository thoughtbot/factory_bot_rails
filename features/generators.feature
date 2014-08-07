Feature:
  In order to easily generate factory files instead of fixture files when generating models
  As a user of Rails and Factory Girl
  I would like to use factory_girl_rails generators.

  Background:
    Given I successfully run `bundle exec rails new testapp`
    And I cd to "testapp"
    And I add "factory_girl_rails" from this project as a dependency

  Scenario: The factory_girl_rails generators create a factory file for each model if there is not a factories.rb file
    When I run `bundle install` with a clean environment
    And I run `bundle exec rails generate model User name:string` with a clean environment
    And I run `bundle exec rails generate model Namespaced::User name:string` with a clean environment
    Then the output should contain "test/factories/users.rb"
    And the output should contain "test/factories/namespaced_users.rb"
    And the file "test/factories/users.rb" should contain "factory :user do"
    And the file "test/factories/namespaced_users.rb" should contain "factory :namespaced_user, :class => 'Namespaced::User' do"

  Scenario: The factory_girl_rails generators does not create a factory file for each model if there is a factories.rb file in the test directory
    When I run `bundle install` with a clean environment
    And I write to "test/factories.rb" with:
      """
      FactoryGirl.define do
      end
      """
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the file "test/factories.rb" should contain "factory :user do"
