# frozen_string_literal: true

require "spec_helper"

describe "factory extensions" do
  describe "#file_fixture" do
    it "delegates to the test harness" do
      FactoryBot.define do
        factory :upload, class: Struct.new(:filename) do
          filename { file_fixture("file.txt") }
        end
      end

      upload = FactoryBot.build(:upload)

      expect(Pathname(upload.filename)).to eq(file_fixture("file.txt"))
    end

    it "uploads an ActiveStorage::Blob" do
      FactoryBot.define do
        factory :active_storage_blob, class: ActiveStorage::Blob do
          filename { pathname.basename }

          transient do
            pathname { file_fixture("file.txt") }
          end

          after :build do |model, factory|
            model.upload factory.pathname.open
          end
        end
      end

      blob = FactoryBot.create(:active_storage_blob)

      expect(blob.filename.to_s).to eq("file.txt")
      expect(blob.download).to eq(file_fixture("file.txt").read)
    end
  end
end
