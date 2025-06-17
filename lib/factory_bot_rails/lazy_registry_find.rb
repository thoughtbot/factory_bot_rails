require "factory_bot/registry"

module FactoryBotRails
  module LazyRegistryFind
    def self.find_definitions_once
      return if defined?(@definitions_loaded)
      FactoryBot.find_definitions
      @definitions_loaded = true
    end

    def find(*)
      LazyRegistryFind.find_definitions_once
      super
    end
  end
end
