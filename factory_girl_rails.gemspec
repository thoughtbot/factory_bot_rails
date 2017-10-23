Gem::Specification.new do |s|
  s.name        = %q{factory_girl_rails}
  s.version     = '4.9.0'
  s.authors     = ["Joe Ferris"]
  s.email       = %q{jferris@thoughtbot.com}
  s.homepage    = "http://github.com/thoughtbot/factory_girl_rails"
  s.summary     = %q{factory_girl_rails provides integration between
    factory_girl and rails 3 or newer}
  s.description = %q{factory_girl_rails provides integration between
    factory_girl and rails 3 or newer (currently just automatic factory definition
    loading)}

  s.files         = Dir['**/*'].keep_if { |file| File.file?(file) }
  s.require_paths = ["lib"]
  s.executables   = []
  s.license       = "MIT"

  s.add_runtime_dependency('railties', '>= 3.0.0')
  s.add_runtime_dependency('factory_girl', '~> 4.9.0')
end
