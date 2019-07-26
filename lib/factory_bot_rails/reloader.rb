# frozen_string_literal: true

require "factory_bot_rails/definition_file_paths"

module FactoryBotRails
  class Reloader
    def initialize(app)
      @app = app
      @paths = DefinitionFilePaths.new(FactoryBot.definition_file_paths)
    end

    def run
      return unless @paths.any?

      reloader = build_reloader
      register_reloader(reloader)
      reloader.execute
    end

    private

    attr_reader :app

    def build_reloader
      reloader_class.new(@paths.files, @paths.directories) do
        FactoryBot.reload
      end
    end

    def reloader_class
      app.config.file_watcher
    end

    def register_reloader(reloader)
      app.reloaders << reloader

      app.reloader.to_prepare do
        reloader.execute
      end
    end
  end
end
