When /^I add "([^"]+)" from this project as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}", :path => "#{PROJECT_ROOT}"\n})
end

When /^I add "([^"]+)" as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}"\n})
end

When /^I set the FactoryGirl :suffix option to "([^"]+)"$/ do |suffix|
  append_to_file('config/application.rb', <<-RUBY)
    module Testapp
      class Application < Rails::Application
        config.generators do |g|
          g.fixture_replacement :factory_girl, :suffix => '#{suffix}'
        end
      end
    end
  RUBY

end

When /^I configure the factories as:$/ do |string|
  append_to_file File.join('config', 'application.rb'), <<-END
class Testapp::Application
  #{string}
end
  END
end

When /^I configure the factories directory as "([^"]+)"$/ do |factory_dir|
  append_to_file File.join('config', 'application.rb'), <<-END
class Testapp::Application
  config.generators do |g|
    g.fixture_replacement :factory_girl, :dir => "#{factory_dir}"
  end
end
  END
end

When /^I configure the testing framework to use MiniTest$/ do
  append_to_file('Gemfile', %{gem "minitest-rails", :group => [:development, :test]\n})
  step %{I run `rails generate mini_test:install` with a clean environment}

  append_to_file File.join('config', 'application.rb'), <<-END
class Testapp::Application
  config.generators do |g|
    g.test_framework :mini_test, :fixture => false, :fixture_replacement => :factory_girl
  end
end
  END
end

When /^I comment out gem "([^"]*)" from my Gemfile$/ do |gem_name|
  in_current_dir do
    content = File.read('Gemfile')
    File.open('Gemfile', 'w') do |f|
      f.write content.sub(/gem ['"]#{gem_name}/, '#\1')
    end
  end
end
