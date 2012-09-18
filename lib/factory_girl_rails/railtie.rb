require 'factory_girl'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators

    initializer "factory_girl.set_fixture_replacement" do
      if generators.options[:rails][:test_framework] == :rspec
        opts = {:dir => 'spec/factories'}.merge(generators.options[:factory_girl])
        generators.fixture_replacement :factory_girl, opts
      else
        generators.test_framework :test_unit, :fixture => false, :fixture_replacement => :factory_girl
      end
    end

    initializer "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths = [
          File.join(Rails.root, 'factories'),
          File.join(Rails.root, 'test', 'factories')
      ]
      # Don't trigger creation of an empty hash
      if generators.options[:factory_girl].has_key?(:dir)
        directory = generators.options[:factory_girl][:dir]
        FactoryGirl.definition_file_paths << File.join(
          Rails.root, *directory.split(File::SEPARATOR)
        )
      end
    end

    config.after_initialize do
      FactoryGirl.find_definitions
    end
  end
end
