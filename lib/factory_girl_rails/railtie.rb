require 'factory_girl'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    initializer "factory_girl.set_fixture_replacement" do
      generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
      rails_options = generators.options[:rails]

      if rails_options[:test_framework] == :rspec
        factory_girl_dir = generators.options.fetch(:factory_girl, { :dir => 'spec/factories' })[:dir]

        if rails_options.has_key?(:fixture_replacement)
          generators.fixture_replacement rails_options[:fixture_replacement], :dir => factory_girl_dir
        else
          generators.fixture_replacement :factory_girl, :dir => factory_girl_dir
        end
      else
        generators.test_framework rails_options[:test_framework], :fixture => false, :fixture_replacement => :factory_girl
      end
    end

    initializer "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths = [
        Rails.root.join('factories'),
        Rails.root.join('test', 'factories'),
        Rails.root.join('spec', 'factories')
      ]
    end

    config.after_initialize do
      FactoryGirl.find_definitions
    end
  end
end
