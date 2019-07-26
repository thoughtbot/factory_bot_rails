# frozen_string_literal: true

describe FactoryBotRails::Reloader do
  describe "#run" do
    before do
      @original_definition_file_paths = FactoryBot.definition_file_paths
    end

    after do
      FactoryBot.definition_file_paths = @original_definition_file_paths
    end

    context "when a definition file paths exist" do
      it "registers a reloader" do
        run_reloader(["spec/fixtures/factories", "not_exist_directory"])

        expect(reloader_class).to have_received(:new)
      end
    end

    context "when a file exists but not a directory" do
      it "registers a reloader" do
        run_reloader(["spec/fake_app", "not_exist_directory"])

        expect(reloader_class).to have_received(:new)
      end
    end

    context "when a definition file paths NOT exist" do
      it "does NOT register a reloader" do
        run_reloader(["not_exist_directory"])

        expect(reloader_class).not_to have_received(:new)
      end
    end

    def run_reloader(definition_file_paths)
      FactoryBot.definition_file_paths = definition_file_paths
      FactoryBotRails::Reloader.new(app).run
    end

    def app
      double(
        :app,
        config: double(:config, file_watcher: reloader_class),
        reloader: double(:reloader, to_prepare: nil),
        reloaders: [],
      )
    end

    def reloader_class
      @reloader_class ||=
        double(
          :reloader_class,
          new: double(:reloader, execute: nil),
        )
    end
  end
end
