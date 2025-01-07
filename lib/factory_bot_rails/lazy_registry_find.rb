require "factory_bot/registry"

module FactoryBotRails
  module LazyRegistryFind
    def find(*)
      FactoryBot.find_definitions unless FactoryBot.factories.any?
      super
    end
  end
end
