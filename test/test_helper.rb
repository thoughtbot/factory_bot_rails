# frozen_string_literal: true

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../spec/fake_app"
require "rails/test_help"
require "factory_bot_rails"