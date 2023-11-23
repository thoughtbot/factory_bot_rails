# frozen_string_literal: true

describe FactoryBotRails::Railtie do
  describe "application reloading" do
    context "when a definition file has been updated" do
      it "reloads the factory definitions" do
        allow(FactoryBot).to receive(:reload)

        touch("factories.rb")
        reload_rails!

        expect(FactoryBot).to have_received(:reload).at_least(1).times
      end
    end

    context "when a file in a definition directory has been updated" do
      it "reloads the factory definitions" do
        allow(FactoryBot).to receive(:reload)

        touch("factories/definitions.rb")
        reload_rails!

        expect(FactoryBot).to have_received(:reload).at_least(1).times
      end
    end

    context "when the factory definitions have NOT been updated" do
      it "reloads the factory definitions" do
        allow(FactoryBot).to receive(:reload)

        reload_rails!

        expect(FactoryBot).to have_received(:reload).at_least(1).times
      end
    end

    def touch(file)
      FileUtils.touch(Rails.root.join(file))
    end

    def reload_rails!
      Rails.application.reloader.reload!
      wait_for_rails_to_reload
    end

    def wait_for_rails_to_reload
      sleep 0.01
    end
  end

  describe "initializer 'factory_bot.reject_primary_key_attributes'" do
    before do
      Rails.application.config.factory_bot.validator = FactoryBotRails::FactoryValidator.new
    end

    context "when config.reject_primary_key_attributes is true" do
      before do
        Rails.application.config.factory_bot.reject_primary_key_attributes = true
        allow(Rails.application.config.factory_bot.validator).to receive(:add_validator)
      end

      it "adds the ActiveRecordValidator to the validator list" do
        run_reject_primary_key_attributes_initializer

        expect(Rails.application.config.factory_bot.validator).to have_received(:add_validator)
      end
    end

    context "when config.reject_primary_key_attributes is false" do
      before do
        Rails.application.config.factory_bot.reject_primary_key_attributes = false
        allow(Rails.application.config.factory_bot.validator).to receive(:add_validator)
      end

      it "does not add the ActiveRecordValidator to the validator list" do
        run_reject_primary_key_attributes_initializer

        expect(Rails.application.config.factory_bot.validator).not_to have_received(:add_validator)
      end
    end

    def run_reject_primary_key_attributes_initializer
      initializer = FactoryBotRails::Railtie.initializers.find do |i|
        i.name == "factory_bot.reject_primary_key_attributes"
      end
      initializer.run(Rails.application)
    end
  end

  describe "initializer order" do
    it "runs 'factory_bot.configuration' before any other initializer" do
      initializers = FactoryBotRails::Railtie.initializers.map(&:name)
      first_initializer = initializers.first

      expect(first_initializer).to eq("factory_bot.configuration")
    end
  end
end
