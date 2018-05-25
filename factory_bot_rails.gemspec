Gem::Specification.new do |s|
  s.name        = %q{factory_bot_rails}
  s.version     = '4.10.0'
  s.authors     = ["Joe Ferris"]
  s.email       = %q{jferris@thoughtbot.com}
  s.homepage    = "http://github.com/thoughtbot/factory_bot_rails"
  s.summary     = %q{factory_bot_rails provides integration between
    factory_bot and rails 3 or newer}
  s.description = %q{factory_bot_rails provides integration between
    factory_bot and rails 3 or newer (currently just automatic factory definition
    loading)}

  s.files         = Dir['**/*'].keep_if { |file| File.file?(file) }
  s.require_paths = ["lib"]
  s.executables   = []
  s.license       = "MIT"

  s.add_runtime_dependency('railties', '>= 3.0.0')
  s.add_runtime_dependency('factory_bot', '~> 4.10.0')
end
