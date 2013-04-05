require 'factory_girl'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    initializer "factory_girl.set_fixture_replacement" do
      generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
      rails_options = generators.options[:rails]
            
      next if rails_options[:factory_girl] == false

      generators.test_framework rails_options[:test_framework], :fixture => false, :fixture_replacement => :factory_girl
      factory_girl_opts = generators.options.fetch(:fixture_replacement, {})
      factory_girl_opts.merge! generators.options.fetch(:factory_girl, {})
      factory_girl_opts = {:dir => 'spec/factories'}.merge factory_girl_opts if rails_options[:test_framework] == :rspec
      generators.fixture_replacement :factory_girl, factory_girl_opts
    end
    
    initializer "factory_girl.set_factory_paths" do
      paths = [
        Rails.root.join('factories'),
        Rails.root.join('test', 'factories'),
        Rails.root.join('spec', 'factories'),
      ]
      
      generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
      custom_dir = generators.options.fetch(:factory_girl).fetch(:dir) rescue false
      # top priority to custom dir
      paths.unshift Rails.root.join(custom_dir) if custom_dir
      # if rspec is the test_framework, there are two 'spec/factories'
      FactoryGirl.definition_file_paths = paths.uniq
    end

    config.after_initialize do
      FactoryGirl.find_definitions
    end
  end
end
