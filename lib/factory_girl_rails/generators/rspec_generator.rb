module FactoryGirlRails
  module Generators
    class RSpecGenerator
      def initialize(generators)
        @generators = generators
      end

      def run
        @generators.fixture_replacement fixture_replacement_setting, dir: factory_girl_directory
      end

      private

      def fixture_replacement_setting
        @generators.options[:rails][:fixture_replacement] || :factory_girl
      end

      def factory_girl_directory
        @generators.options.fetch(:factory_girl, {}).fetch(:dir, 'spec/factories')
      end
    end
  end
end
