When /^I add "([^"]+)" from this project as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}", :path => "#{PROJECT_ROOT}"\n})
end

When /^I add "([^"]+)" as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}"\n})
end

When /^I set the FactoryGirl :dir option to "([^"]+)"$/ do |directory|
  append_to_file('config/application.rb', <<-RUBY)
    module Testapp
      class Application < Rails::Application
        config.generators do |g|
          g.fixture_replacement :factory_girl, :dir => '#{directory}'
        end
      end
    end
  RUBY
end
