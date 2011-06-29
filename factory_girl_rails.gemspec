Gem::Specification.new do |s|
  s.name        = %q{factory_girl_rails}
  s.version     = '1.1.beta3'
  s.summary     = %q{factory_girl_rails provides integration between
    factory_girl and rails 3}
  s.description = %q{factory_girl_rails provides integration between
    factory_girl and rails 3 (currently just automatic factory definition
    loading)}
  s.files        = Dir['[A-Z]*', 'lib/**/*.rb', 'spec/**/*.rb', 'features/**/*']
  s.require_path = 'lib'
  s.test_files   = Dir['spec/**/*_spec.rb', 'features/**/*']
  s.authors = ["Joe Ferris"]
  s.email   = %q{jferris@thoughtbot.com}
  s.homepage = "http://github.com/thoughtbot/factory_girl_rails"
  s.add_runtime_dependency('railties', '>= 3.0.0')
  s.add_runtime_dependency('factory_girl', '~> 2.0.0.beta')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 2.6.0')
  s.add_development_dependency('cucumber', '~> 1.0.0')
  s.add_development_dependency('aruba')
  s.add_development_dependency('rails', '3.0.7')

  s.platform = Gem::Platform::RUBY
  s.rubygems_version = %q{1.2.0}
end

