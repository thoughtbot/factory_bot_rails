require 'bundler'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

desc "Default: run the cucumber scenarios"
task :default => :cucumber
