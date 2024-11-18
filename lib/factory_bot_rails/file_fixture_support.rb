module FactoryBotRails
  module FileFixtureSupport
    def self.included(klass)
      klass.class_attribute :file_fixture_support, instance_accessor: false

      klass.delegate :file_fixture, to: "self.class.file_fixture_support"
    end
  end
end
