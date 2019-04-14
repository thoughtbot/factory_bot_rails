Gem::Specification.new do |s|
  s.name        = "factory_bot_rails"
  s.version     = "5.0.2"
  s.authors     = ["Joe Ferris"]
  s.email       = "jferris@thoughtbot.com"
  s.homepage    = "https://github.com/thoughtbot/factory_bot_rails"
  s.summary     = "factory_bot_rails provides integration between "\
                  "factory_bot and rails 4.2 or newer"
  s.description = "factory_bot_rails provides integration between "\
                  "factory_bot and rails 4.2 or newer"

  s.files         = Dir["lib/**/*"] + %w[CONTRIBUTING.md LICENSE NEWS README.md]
  s.require_paths = ["lib"]
  s.executables   = []
  s.license       = "MIT"

  s.add_runtime_dependency("factory_bot", "~> 5.0.2")
  s.add_runtime_dependency("railties", ">= 4.2.0")
end
