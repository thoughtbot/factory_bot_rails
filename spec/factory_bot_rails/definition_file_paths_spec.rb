# frozen_string_literal: true

describe FactoryBotRails::DefinitionFilePaths do
  describe "#files" do
    it "returns a list of definition files that only exist" do
      definition_file_paths = ["spec/fixtures/factories", "not_exist_directory"]

      files = described_class.new(definition_file_paths).files

      expect(files).to eq ["spec/fixtures/factories.rb"]
    end
  end

  describe "#directories" do
    it "returns a hash of definition directories that only exist" do
      definition_file_paths = ["spec/fixtures/factories", "not_exist_directory"]

      directories = described_class.new(definition_file_paths).directories

      expect(directories).to eq(
        "spec/fixtures/factories" => [:rb]
      )
    end

    it "converts Pathname objects to strings" do
      definition_file_paths = [Pathname.new("spec/fixtures/factories")]

      directories = described_class.new(definition_file_paths).directories

      expect(directories).to eq("spec/fixtures/factories" => [:rb])
    end
  end

  describe "#any?" do
    it "returns true only if definition file paths exist" do
      definition_file_paths = ["spec/fixtures/factories", "not_exist_directory"]
      expect(described_class.new(definition_file_paths).any?).to eq true

      definition_file_paths = ["not_exist_directory"]
      expect(described_class.new(definition_file_paths).any?).to eq false
    end
  end
end
