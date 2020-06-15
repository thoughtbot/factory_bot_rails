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
        file_watcher = file_watcher_double

        run_reloader(
          ["spec/fixtures/factories", "not_exist_directory"],
          file_watcher
        )

        expect(file_watcher).to have_received(:new)
      end
    end

    context "when a file exists but not a directory" do
      it "registers a reloader" do
        file_watcher = file_watcher_double

        run_reloader(
          ["spec/fake_app", "not_exist_directory"],
          file_watcher
        )

        expect(file_watcher).to have_received(:new)
      end
    end

    context "when a definition file paths NOT exist" do
      it "does NOT register a reloader" do
        file_watcher = file_watcher_double

        run_reloader(["not_exist_directory"], file_watcher)

        expect(file_watcher).not_to have_received(:new)
      end
    end

    def run_reloader(definition_file_paths, file_watcher)
      FactoryBot.definition_file_paths = definition_file_paths
      app = app_double(file_watcher)
      FactoryBotRails::Reloader.new(app).run
    end

    def file_watcher_double
      class_double(
        Rails.application.config.file_watcher,
        new: double(:reloader, execute: nil)
      )
    end

    def app_double(file_watcher)
      instance_double(
        Rails.application.class,
        config: app_config_double(file_watcher),
        reloader: reloader_double,
        reloaders: []
      )
    end

    def app_config_double(file_watcher)
      instance_double(
        Rails.application.config.class,
        file_watcher: file_watcher
      )
    end

    def reloader_double
      class_double(
        Rails.application.reloader,
        to_prepare: nil
      )
    end
  end
end
