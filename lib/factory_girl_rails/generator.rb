require 'factory_girl_rails/generators/rspec_generator'
require 'factory_girl_rails/generators/non_rspec_generator'
require 'factory_girl_rails/generators/null_generator'

module FactoryGirlRails
  class Generator
    def initialize(config)
      @generators = if config.respond_to?(:app_generators)
                      config.app_generators
                    else
                      config.generators
                    end
    end

    def run
      generator.new(@generators).run
    end

    def generator
      if factory_girl_disabled?
        Generators::NullGenerator
      else
        if test_framework == :rspec
          Generators::RSpecGenerator
        else
          Generators::NonRSpecGenerator
        end
      end
    end

    def test_framework
      rails_options[:test_framework]
    end

    def factory_girl_disabled?
      rails_options[:factory_girl] == false
    end

    def rails_options
      @generators.options[:rails]
    end
  end
end
