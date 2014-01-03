require 'factory_girl'
require 'factory_girl_rails/generator'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    initializer "factory_girl.set_fixture_replacement" do
      FactoryGirlRails::Generator.new(config).run
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

      if defined?(Spring)
        Spring.after_fork { FactoryGirl.reload }
      end
    end
  end
end
