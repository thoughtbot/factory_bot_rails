# frozen_string_literal: true

module FactoryBotRails
  class DefinitionFilePaths
    attr_reader :files, :directories

    def initialize(definition_file_paths)
      @files = []
      @directories = {}

      definition_file_paths.each do |path|
        @files << "#{path}.rb"
        @directories[path.to_s] = [:rb]
      end
    end
  end
end
