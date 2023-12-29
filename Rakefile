require "bundler/setup"
require "cucumber/rake/task"
require "rspec/core/rake_task"
require "standard/rake"

Bundler::GemHelper.install_tasks name: "factory_bot_rails"

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ["--format", ENV.fetch("CUCUMBER_FORMAT", "progress")]
end

RSpec::Core::RakeTask.new(:spec)

desc "Run the test suite and standard"
task default: %w[spec cucumber standard]
