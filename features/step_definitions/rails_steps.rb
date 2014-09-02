When /^I add "([^"]+)" from this project as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}", :path => "#{PROJECT_ROOT}"\n})
end

When /^I add "([^"]+)" as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}"\n})
end

When /^I print out "([^"]*)"$/ do |path|
  in_current_dir do
    File.open(path, 'r') do |f|
      puts f.inspect
    end
  end
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

When /^I comment out gem "([^"]*)" from my Gemfile$/ do |gem_name|
  in_current_dir do
    content = File.read('Gemfile')
    File.open('Gemfile', 'w') do |f|
      f.write content.sub(/gem ['"]#{gem_name}/, '#\1')
    end
  end
end
