require 'factory_girl'
require 'rails'

class Factory
  class Railtie < Rails::Railtie
    config.after_initialize do

      factory_destination_directory = "#{defined?(RSpec)? "spec" : "test"}/factories"

      config.generators.fixture_replacement :factory_girl, :dir => factory_destination_directory

      Factory.definition_file_paths = [
        File.join(Rails.root, 'test', 'factories'),
        File.join(Rails.root, 'spec', 'factories')
      ]
      Factory.find_definitions
    end
  end
end

