require "generators/factory_bot"
require "factory_bot_rails"

module FactoryBot
  module Generators
    class ModelGenerator < Base
      argument(
        :attributes,
        type: :array,
        default: [],
        banner: "field:type field:type",
      )

      class_option(
        :dir,
        type: :string,
        default: "test/factories",
        desc: "The directory or file root where factories belong",
      )

      class_option(
        :suffix,
        type: :string,
        default: nil,
        desc: "Suffix to add factory file",
      )

      def create_fixture_file
        if File.exist?(factories_file)
          insert_factory_into_existing_file
        else
          create_factory_file
        end
      end

      private

      def factories_file
        options[:dir] + ".rb"
      end

      def insert_factory_into_existing_file
        insert_into_file(
          factories_file,
          factory_definition,
          after: "FactoryBot.define do\n",
        )
      end

      def create_factory_file
        file = File.join(options[:dir], "#{filename}.rb")
        template "factories.erb", file
      end

      def factory_definition
        <<~RUBY
            factory :#{singular_table_name}#{explicit_class_option} do
          #{factory_attributes.gsub(/^/, '    ')}
            end

        RUBY
      end

      # rubocop:disable Metrics/MethodLength, Layout/LineLength, Metrics/PerceivedComplexity
      def factory_attributes
        i = 0
        attributes.map do |attribute|
          attribute_name = attribute.name
          if attribute.reference?
            "association :#{attribute_name}, factory: :#{attribute_name}"
          elsif attribute_name == "email"
            "sequence(:#{attribute_name}) {|n| \"email#\{format '%03d', n}@gmail.com\" }"
          elsif attribute_name =~ /(.*)_url$/
            "sequence(:#{attribute_name}) {|n| \"http://#{$1}#\{format '%03d', n}.com\" }"
          elsif attribute_name == "password"
            "password {'password'}"
          elsif attribute_name == "password_confirmation"
            "password_confirmation {'password'}"
          elsif attribute_name == "position"
            "sequence(:#{attribute_name}) {|n| n }"
          elsif %i[string text].include? attribute.type
            "sequence(:#{attribute_name}) {|n| \"#{attribute_name.capitalize.gsub('_', ' ')}#\{format '%03d', n}\" }"
          elsif attribute.type == :integer
            i += 1
            "sequence(:#{attribute_name}) {|n| \"#{i}#\{format '%03d', n}\" }"
          else
            "#{attribute_name} { #{attribute.default.inspect} }"
          end
        end.join("\n")
      end
      # rubocop:enable Metrics/MethodLength, Layout/LineLength, Metrics/PerceivedComplexity

      def filename
        if factory_bot_options[:filename_proc].present?
          factory_bot_options[:filename_proc].call(table_name)
        else
          name = File.join(class_path, plural_name)
          [name, filename_suffix].compact.join("_")
        end
      end

      def filename_suffix
        factory_bot_options[:suffix] || options[:suffix]
      end

      def factory_bot_options
        generators.options[:factory_bot] || {}
      end

      def generators
        FactoryBotRails::Railtie.config.app_generators
      end
    end
  end
end
