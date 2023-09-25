# frozen_string_literal: true

require "rails/all"
require "rspec/rails"

describe "factory extensions" do
  include FactoryBot::Syntax::Methods

  describe "#file_fixture" do
    it "delegates to the test harness" do
      define_model "Upload", filename: :string

      FactoryBot.define do
        factory :upload do
          filename { file_fixture("file.txt") }
        end
      end

      upload = build(:upload)

      expect(Pathname(upload.filename)).to eq(file_fixture("file.txt"))
    end
  end
end
