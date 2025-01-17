# frozen_string_literal: true

ENV["DATABASE_URL"] = "sqlite3::memory:"

require "active_record/railtie"
require "active_storage/engine"

module Dummy
  class Application < Rails::Application
    config.eager_load = false
    config.root = "spec/fixtures"

    if Rails.gem_version >= Gem::Version.new("7.1")
      config.active_support.cache_format_version = 7
    end

    config.active_storage.service = :local
    config.active_storage.service_configurations = {
      local: {
        root: root.join("tmp/storage"),
        service: "Disk"
      }
    }
  end
end

Rails.logger = Logger.new("/dev/null")

Rails.application.initialize!
