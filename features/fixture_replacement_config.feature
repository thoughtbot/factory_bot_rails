Feature:
  In order to not have to manually configure factory girl as the testing fixture replacement by using the --fixture-replacement=factory_girl option as a Rails3 and Factory Girl user
  I would like the Factory Girl Rails gem to configure Factory Girl as the fixture replacement.

  Background:
    Given I successfully run `bundle exec rails new testapp`
    And I cd to "testapp"
    And I add "factory_girl_rails" from this project as a dependency

  Scenario: Using Factory Girl and Factory Girl Rails with Test Unit generates a factory file and does not generate a fixture file
    And I run `bundle install` with a clean environment
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should exist:
      | test/factories/users.rb |
    And the following files should not exist:
      | test/fixtures/users.yml |

  Scenario: Using Factory Girl and Factory Girl Rails with RSpec should generate a factory file
    When I add "rspec-rails" as a dependency
    And I configure the factories as:
      """
      config.generators do |g|
        g.test_framework :rspec, fixture: true
        g.fixture_replacement :factory_girl
      end
      """
    And I run `bundle install` with a clean environment
    Then the output should contain "rspec-rails"
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should exist:
      | spec/factories/users.rb |
    And the following files should not exist:
      | spec/fixtures/users.yml |

  Scenario: Using Factory Girl and Factory Girl Rails does not override a manually-configured factories directory using RSpec
    When I add "rspec-rails" as a dependency
    And I configure the factories directory as "custom/dir"
    And I run `bundle install` with a clean environment
    Then the output should contain "rspec-rails"
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should not exist:
      | test/factories/users.rb |
      | spec/factories/users.rb |
    But the following files should exist:
      | custom/dir/users.rb |

  Scenario: Using Factory Girl and Factory Girl Rails does not override a manually-configured factories directory using Test::Unit
    When I configure the factories directory as "custom/dir"
    And I run `bundle install` with a clean environment
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should not exist:
      | test/factories/users.rb |
      | spec/factories/users.rb |
    But the following files should exist:
      | custom/dir/users.rb |

  Scenario: Using Factory Girl and Factory Girl Rails with MiniTest should generate a factory file
    When I add "minitest" as a dependency
    And I configure the testing framework to use MiniTest
    And I run `bundle install` with a clean environment
    Then the output should contain "minitest"
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should exist:
      | test/factories/users.rb |
    But the following files should not exist:
      | spec/fixtures/users.yml |

  Scenario: Using Factory Girl and Factory Girl Rails with MiniTest and a custom directory should generate a factory file
    When I configure the factories directory as "custom/dir"
    And I add "minitest" as a dependency
    And I configure the testing framework to use MiniTest
    And I run `bundle install` with a clean environment
    Then the output should contain "minitest"
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should exist:
      | custom/dir/users.rb |
    But the following files should not exist:
      | spec/fixtures/users.yml |
    And the file "test/models/user_test.rb" should contain "MiniTest::Rails::ActiveSupport::TestCase"

  Scenario: Disable Factory Girl generator
    When I configure the factories as:
      """
      config.generators do |g|
        g.factory_girl false
      end
      """
    And I run `bundle install` with a clean environment
    And I run `bundle exec rails generate model User name:string` with a clean environment
    Then the following files should not exist:
      | test/factories/users.rb |
      | spec/factories/users.rb |
