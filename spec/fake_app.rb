# frozen_string_literal: true

module Dummy
  class Application < Rails::Application
    config.eager_load = false
    config.root = "spec/fixtures"

    if Rails.gem_version >= Gem::Version.new("7.1")
      config.active_support.cache_format_version = 7
    end
  end
end

Rails.logger = Logger.new("/dev/null")

Rails.application.initialize!
