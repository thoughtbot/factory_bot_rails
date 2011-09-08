@disable-bundler
Feature:
  In order to not have to manually configure factory girl as the testing fixture replacement
  by using the --fixture-replacement=factory_girl option
  as a Rails3 and Factory Girl user
  I would like the Factory Girl Rails gem to configure Factory Girl
  as the fixture replacement.

  Background:
    Given I successfully run `bundle exec rails new testapp`
    And I cd to "testapp"
    And I add "factory_girl_rails" from this project as a dependency

  Scenario: Using Factory Girl and Factory Girl Rails with Test Unit generates
  a factory file and does not generate a fixture file
    And I successfully run `bundle install`
    And I successfully run `bundle exec rails generate model User name:string`
    Then the following files should exist:
      | test/factories/users.rb |
    And the following files should not exist:
      | test/fixtures/users.yml |


  Scenario: Using Factory Girl and Factory Girl Rails with RSpec should generate a factory file
    And I add "rspec-rails" as a dependency
    And I successfully run `bundle install`
    And I successfully run `bundle exec rails generate model User name:string`
    Then the following files should exist:
      | spec/factories/users.rb |
    And the following files should not exist:
      | spec/fixtures/users.yml |
