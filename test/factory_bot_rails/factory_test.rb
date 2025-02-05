# frozen_string_literal: true

require "test_helper"

class FactoryBotRails::FactoryTest < ActiveSupport::TestCase
  self.file_fixture_path = "test/fixtures/files"

  test "delegates #file_fixture to the test harness" do
    FactoryBot.define do
      factory :upload, class: Struct.new(:filename) do
        filename { file_fixture("file.txt") }
      end
    end

    upload = FactoryBot.build(:upload)

    assert_equal file_fixture("file.txt"), upload.filename
  end

  test "uploads an ActiveStorage::Blob" do
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

    assert_equal "file.txt", blob.filename.to_s
    assert_equal file_fixture("file.txt").read, blob.download
  end
end
