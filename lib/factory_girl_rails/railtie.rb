require 'factory_girl'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    initializer "factory_girl.set_fixture_replacement" do
      generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
      rails_options = generators.options[:rails]

      if rails_options[:test_framework] == :rspec
        if !rails_options.has_key?(:fixture_replacement)
          generators.fixture_replacement :factory_girl, :dir => 'spec/factories'
        end
      else
        generators.test_framework rails_options[:test_framework], :fixture => false, :fixture_replacement => :factory_girl
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
