When /^I add "([^"]+)" from this project as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}", :path => "#{PROJECT_ROOT}"\n})
end

When /^I add "([^"]+)" as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}"\n})
end

When /^I configure the factories directory as "([^"]+)"$/ do |factory_dir|
	append_to_file File.join('config', 'application.rb'), <<-END
class Testapp::Application
	config.generators do |g|
		g.test_framework :rspec, :fixture => true, :views => false
		g.fixture_replacement :factory_girl, :dir => "#{factory_dir}"
	end
end
		END
end
