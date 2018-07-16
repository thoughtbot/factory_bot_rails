# frozen_string_literal: true

require "factory_bot"
require "factory_bot_rails/generator"
require "factory_bot_rails/reloader"
require "rails"

module FactoryBotRails
  class Railtie < Rails::Railtie

    initializer "factory_bot.set_fixture_replacement" do
      Generator.new(config).run
    end

    initializer "factory_bot.set_factory_paths" do
      FactoryBot.definition_file_paths = [
        Rails.root.join("factories"),
        Rails.root.join("test", "factories"),
        Rails.root.join("spec", "factories"),
      ]
    end

    initializer "factory_bot.register_reloader" do |app|
      Reloader.new(app, config).run
    end

    config.after_initialize do
      FactoryBot.find_definitions
    end
  end
end
