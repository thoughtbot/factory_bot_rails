# frozen_string_literal: true

describe "factory extensions" do
  describe "#file_fixture" do
    it "delegates to the test harness" do
      define_model "Upload", filename: :string

      FactoryBot.define do
        factory :upload do
          filename { file_fixture("file.txt") }
        end
      end

      upload = FactoryBot.build(:upload)

      expect(upload.filename).to eq(file_fixture("file.txt").to_s)
    end
  end
end
