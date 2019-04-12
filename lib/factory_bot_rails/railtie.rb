# frozen_string_literal: true

require "factory_bot"
require "factory_bot_rails/generator"
require "factory_bot_rails/reloader"
require "rails"

module FactoryBotRails
  class Railtie < Rails::Railtie
    config.factory_bot = ActiveSupport::OrderedOptions.new
    config.factory_bot.definition_file_paths = FactoryBot.definition_file_paths

    initializer "factory_bot.set_fixture_replacement" do
      Generator.new(config).run
    end

    initializer "factory_bot.set_factory_paths" do
      FactoryBot.definition_file_paths = definition_file_paths
    end

    initializer "factory_bot.register_reloader" do |app|
      Reloader.new(app, config).run
    end

    config.after_initialize do
      FactoryBot.reload
    end

    private

    def definition_file_paths
      config.factory_bot.definition_file_paths.map do |path|
        Rails.root.join(path)
      end
    end
  end
end
