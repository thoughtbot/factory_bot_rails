# frozen_string_literal: true

describe FactoryBotRails::DefinitionFilePaths do
  describe "#files" do
    it "returns a list of definition files" do
      definition_file_paths = ["definition_path", "another_definition_path"]

      files = described_class.new(definition_file_paths).files

      expect(files).to eq ["definition_path.rb", "another_definition_path.rb"]
    end
  end

  describe "#directories" do
    it "returns a hash of definition directories" do
      definition_file_paths = ["definition_path", "another_definition_path"]

      directories = described_class.new(definition_file_paths).directories

      expect(directories).to eq(
        "definition_path" => [:rb],
        "another_definition_path" => [:rb],
      )
    end

    it "converts Pathname objects to strings" do
      definition_file_paths = [Pathname.new("definition_path")]

      directories = described_class.new(definition_file_paths).directories

      expect(directories).to eq("definition_path" => [:rb])
    end
  end
end
