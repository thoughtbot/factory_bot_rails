# These are the versions of Rails we want to test against.
appraise "rails5.0" do
  gem "activerecord", "~> 5.0.7.2"
  gem "railties", "~> 5.0.7.2"
  gem "sqlite3", "~> 1.3.6"
  gem "actionmailer", "~> 5.0.7.2"
  gem "sass-rails"
end

appraise "rails5.1" do
  gem "activerecord", "~> 5.1.7"
  gem "railties", "~> 5.1.7"
  gem "actionmailer", "~> 5.1.7"
  gem "sass-rails"
end

appraise "rails5.2" do
  gem "byebug", platforms: :ruby
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "jbuilder", "~> 2.5"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "puma", "~> 3.11"
  gem "rails", "~> 5.2.4", ">= 5.2.4.2"
  gem "sass-rails", "~> 5.0"
  gem "selenium-webdriver"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "sqlite3", "~> 1.3.6", platforms: :ruby
  gem "web-console", ">= 3.3.0", group: :development
end

appraise "rails6.0" do
  gem "byebug", platforms: :ruby
  gem "capybara", ">= 2.15"
  gem "jbuilder", "~> 2.7"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "puma", "~> 4.1"
  gem "rails", "~> 6.0.2", ">= 6.0.2.2"
  gem "sass-rails", ">= 6"
  gem "selenium-webdriver"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "sqlite3", "~> 1.4", platforms: :ruby
  gem "web-console", ">= 3.3.0", group: :development
  gem "webdrivers"
end
