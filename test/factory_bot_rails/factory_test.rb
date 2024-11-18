# frozen_string_literal: true

require "test_helper"

class FactoryBotRails::FactoryTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  Upload = Struct.new(:filename)

  self.file_fixture_path = "test/fixtures/files"

  test "delegates #file_fixture to the test harness" do
    FactoryBot.define do
      factory :upload, class: Upload do
        filename { file_fixture("file.txt") }
      end
    end

    upload = build(:upload)

    assert_equal file_fixture("file.txt"), upload.filename
  end
end
