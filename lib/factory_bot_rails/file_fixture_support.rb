module FactoryBotRails
  module FileFixtureSupport
    def self.included(klass)
      klass.class_attribute :file_fixture_support

      klass.delegate :file_fixture, to: :file_fixture_support
    end
  end
end
