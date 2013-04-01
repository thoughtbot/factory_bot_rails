if RUBY_VERSION >= '2.0'
  rails_versions = ['3.2.13']
else
  rails_versions = ['3.0.20', '3.1.11']
end

rails_versions.each do |rails_version|
  appraise "#{rails_version}" do
    gem 'rails', rails_version

    unless rails_version =~ /^3.0/
      gem 'coffee-rails'
      gem 'sass-rails'
      gem 'uglifier'
    end

    gem 'activerecord-jdbcsqlite3-adapter', '~> 1.2.5', platforms: :jruby
    gem 'jquery-rails'
    gem 'minitest-rails'
    gem 'rspec-rails'
    gem 'sqlite3', '>= 1.3.4', platforms: :mri
    gem 'therubyrhino'
  end
end
