require 'factory_girl'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    initializer "factory_girl.set_fixture_replacement" do
      generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
      options    = generators.options[:rails]

      if options[:test_framework] == :rspec && !options.has_key?(:fixture_replacement)
        generators.fixture_replacement :factory_girl
      end
    end

    initializer "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths = [
          File.join(Rails.root, 'factories'),
          File.join(Rails.root, 'test', 'factories'),
          File.join(Rails.root, 'spec', 'factories')
      ]
    end

    config.after_initialize do
      FactoryGirl.find_definitions
    end
  end
end

