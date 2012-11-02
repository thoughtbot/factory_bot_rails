require 'bundler/setup'
require 'bundler/gem_tasks'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

require 'appraisal'

desc 'Run the test suite'
task :default do |t|
  if ENV['BUNDLE_GEMFILE'] =~ /gemfiles/
    exec 'rake cucumber'
  else
    Rake::Task['appraise'].execute
  end
end

task :appraise => ['appraisal:install'] do |t|
  exec 'rake appraisal'
end
