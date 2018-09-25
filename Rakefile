require "bundler/setup"
require "cucumber/rake/task"
require "rspec/core/rake_task"

Bundler::GemHelper.install_tasks name: "factory_bot_rails"

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ["--format", (ENV["CUCUMBER_FORMAT"] || "progress")]
end

RSpec::Core::RakeTask.new(:spec)

require "appraisal"

desc "Run the test suite"
task :default do |_|
  if ENV["BUNDLE_GEMFILE"] =~ /gemfiles/
    exec "rake spec && rake cucumber"
  else
    Rake::Task["appraise"].execute
  end
end

task appraise: ["appraisal:install"] do |_|
  exec "rake appraisal"
end
