# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "factory_bot_rails"
require "fake_app"

Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
end
