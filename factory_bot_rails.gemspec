$LOAD_PATH << File.expand_path("lib", __dir__)
require "factory_bot_rails/version"

Gem::Specification.new do |s|
  s.name = "factory_bot_rails"
  s.version = FactoryBotRails::VERSION
  s.authors = ["Joe Ferris"]
  s.email = "jferris@thoughtbot.com"
  s.homepage = "https://github.com/thoughtbot/factory_bot_rails"
  s.summary = "factory_bot_rails provides integration between " \
                  "factory_bot and Rails 6.1 or newer"
  s.description = "factory_bot_rails provides integration between " \
                  "factory_bot and Rails 6.1 or newer"

  s.files = Dir["lib/**/*"] + %w[CONTRIBUTING.md LICENSE NEWS.md README.md]
  s.metadata["changelog_uri"] = "https://github.com/thoughtbot/factory_bot_rails/blob/main/NEWS.md"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0.0")
  s.executables = []
  s.license = "MIT"

  s.add_runtime_dependency("factory_bot", "~> 6.5")
  s.add_runtime_dependency("railties", ">= 6.1.0")

  s.add_development_dependency("activerecord", ">= 6.1.0")
  s.add_development_dependency("activestorage", ">= 6.1.0")
  s.add_development_dependency("mutex_m")
  s.add_development_dependency("sqlite3")
  s.add_development_dependency("appraisal")
  s.add_development_dependency("aruba")
  s.add_development_dependency("cucumber")
  s.add_development_dependency("rake")
  s.add_development_dependency("rspec-rails")
  s.add_development_dependency("standard")
end
