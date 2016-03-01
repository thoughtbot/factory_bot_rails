require 'generators/factory_girl'
require 'factory_girl_rails'

module FactoryGirl
  module Generators
    class ModelGenerator < Base
      argument :attributes, type: :array, default: [], banner: "field:type field:type"
      class_option :dir, type: :string, default: "test/factories", desc: "The directory where the factories should go"
      class_option :suffix, type: :string, default: nil, desc: "Suffix to add factory file"

      def create_fixture_file
        template 'fixtures.erb', File.join(options[:dir], "#{filename}.rb")
      end

      private

      def filename
        if factory_girl_options[:filename_proc].present?
          factory_girl_options[:filename_proc].call(table_name)
        else
          [table_name, filename_suffix].compact.join('_')
        end
      end

      def filename_suffix
        factory_girl_options[:suffix] || options[:suffix]
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
