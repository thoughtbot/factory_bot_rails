require 'aruba/cucumber'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..', '..')).freeze

Before do
  @aruba_timeout_seconds = 3600
end

Aruba.configure do |config|
  config.before_cmd do |cmd|
    set_env('JRUBY_OPTS', "-X-C #{ENV['JRUBY_OPTS']}") # disable JIT since these processes are so short lived

    java_options = ENV['JAVA_OPTS']

    if 1.size == 4 # 4 for 32 bit java, 8 for 64 bit java.
      set_env('JAVA_OPTS', "-d32 #{java_options}")
    else
      set_env('JAVA_OPTS', "-XX:+TieredCompilation -XX:TieredStopAtLevel=1 #{java_options}")
    end
  end
end if RUBY_PLATFORM == 'java'
