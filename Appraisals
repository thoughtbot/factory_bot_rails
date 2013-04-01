if RUBY_VERSION >= '2.0'
  rails_versions = ['3.2.13.rc2']
else
  rails_versions = ['3.0.20', '3.1.11', '3.2.12']
end

rails_versions.each do |rails_version|
  appraise "#{rails_version}" do
    gem 'rails', rails_version

    unless rails_version =~ /^3.0/
      gem 'sass-rails'
      gem 'coffee-rails'
      gem 'uglifier'
    end

    gem 'sqlite3', '>= 1.3.4', platforms: :mri
    gem 'activerecord-jdbcsqlite3-adapter', '~> 1.2.5', platforms: :jruby
    gem 'minitest-rails'
    gem 'therubyrhino'
    gem 'jquery-rails'
    gem 'rspec-rails'
  end
end
