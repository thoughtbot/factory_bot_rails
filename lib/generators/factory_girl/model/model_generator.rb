require 'generators/factory_girl'

module FactoryGirl
  module Generators
    class ModelGenerator < Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      class_option :dir, :type => :string, :default => "test/factories", :desc => "The directory where the factories should go"

      def create_fixture_file
        config = FactoryGirl::Railtie.config
        generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators

        if generators.options[:factory_girl] && generators.options[:factory_girl][:suffix]
          filename_suffix =  '_' + generators.options[:factory_girl][:suffix]
        else
          filename_suffix = ''
        end
        filename = "#{table_name}#{filename_suffix}.rb"
        template 'fixtures.erb', File.join(options[:dir], filename)
      end
    end
  end
end
