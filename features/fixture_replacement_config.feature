Feature:
  In order to not have to manually configure factory girl as the testing fixture replacement
  by using the --fixture-replacement=factory_girl option
  as a Rails3 and Factory Girl user
  I would like the Factory Girl Rails gem to configure Factory Girl
  as the fixture replacement.

  Background:
    Given I run "rails new test_app"
    And I cd to "test_app"

  # For some reason I can't figure out how to get test unit or shoulda to
  # tie in the fixture replacement without specifying the --fixture-replacement
  # command line option so for now we'll just wire in rspec

  Scenario: Using Factory Girl and Factory Girl Rails with Test Unit does not generate
  a factory file but should generate a fixture file
    Given a file named "Gemfile" with:
    """
    source "http://rubygems.org"
    gem 'rails', '3.0.0'
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'factory_girl_rails', :path => '../../../'
    """
    When I run "bundle install"
    And I run "rails generate model User name:string"
    Then the following files should exist:
      | test/fixtures/users.yml |
    And the following files should not exist:
      | test/factories/users.rb |


  Scenario: Using Factory Girl and Factory Girl Rails with Shoulda does not generate
  a factory file but should generate a fixture file
    Given a file named "Gemfile" with:
    """
    source "http://rubygems.org"
    gem 'rails', '3.0.0'
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'shoulda'
    gem 'factory_girl_rails', :path => '../../../'
    """
    When I run "bundle install"
    And I run "rails generate model User name:string"
    Then the following files should exist:
      | test/fixtures/users.yml |
    And the following files should not exist:
      | test/factories/users.rb |


  Scenario: Using Factory Girl and Factory Girl Rails with RSpec should generate a
  factory file
    Given a file named "Gemfile" with:
    """
    source "http://rubygems.org"
    gem 'rails', '3.0.0'
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'factory_girl_rails', :path => '../../../'
    gem 'rspec-rails', '2.0.0.beta.22'
    """
    When I run "bundle install"
    And I run "rails generate model User name:string"
    Then the file "spec/factories/users.rb" should contain "Factory.define :user"