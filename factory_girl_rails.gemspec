Gem::Specification.new do |s|
  s.name        = %q{factory_girl_rails}
  s.version     = '4.5.0'
  s.authors     = ["Joe Ferris"]
  s.email       = %q{jferris@thoughtbot.com}
  s.homepage    = "http://github.com/thoughtbot/factory_girl_rails"
  s.summary     = %q{factory_girl_rails provides integration between
    factory_girl and rails 3}
  s.description = %q{factory_girl_rails provides integration between
    factory_girl and rails 3 (currently just automatic factory definition
    loading)}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.license       = "MIT"

  s.add_runtime_dependency('railties', '>= 3.0.0')
  s.add_runtime_dependency('factory_girl', '~> 4.5.0')
end
