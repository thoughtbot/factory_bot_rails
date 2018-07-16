# frozen_string_literal: true

module Dummy
  class Application < Rails::Application
    config.eager_load = false
    config.root = "spec/fixtures"
  end
end

Rails.logger = Logger.new("/dev/null")

Rails.application.initialize!
