require 'generators/factory_girl'
require 'factory_girl_rails'

module FactoryGirl
  module Generators
    class ModelGenerator < Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      class_option :dir, :type => :string, :default => "test/factories", :desc => "The directory where the factories should go"

      def create_fixture_file
        filename = [table_name, filename_suffix].compact.join('_')
        template 'fixtures.erb', File.join(options[:dir], "#{filename}.rb")
      end

      private

      def filename_suffix
        factory_girl_options[:suffix]
      end

      def generators
        config = FactoryGirl::Railtie.config
        config.respond_to?(:app_generators) ? config.app_generators : config.generators
      end

      def factory_girl_options
        generators.options[:factory_girl] || {}
      end
    end
  end
end
