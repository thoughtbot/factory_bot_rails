require "aruba/cucumber"

PROJECT_ROOT =
  File.expand_path(File.join(File.dirname(__FILE__), "..", "..")).freeze

Aruba.configure do |config|
  config.exit_timeout = Integer ENV.fetch("ARUBA_TIMEOUT", 120)
end

Before do
  setup_aruba
end

Before("@rails_8") do
  rails_version = Gem::Version.new(
    Bundler.load.specs.find { |spec| spec.name == "rails" }&.version.to_s
  )
  required_version = Gem::Version.new("8.0.0")

  if rails_version < required_version
    skip_this_scenario("Requires Rails 8.0 or higher (current: #{rails_version})")
  end
end

if RUBY_PLATFORM == "java"
  Aruba.configure do |config|
    config.before_cmd do
      # disable JIT since these processes are so short lived
      set_env("JRUBY_OPTS", "-X-C #{ENV["JRUBY_OPTS"]}")

      java_options = ENV["JAVA_OPTS"]

      if 1.size == 4 # 4 for 32 bit java, 8 for 64 bit java.
        set_env("JAVA_OPTS", "-d32 #{java_options}")
      else
        set_env(
          "JAVA_OPTS",
          "-XX:+TieredCompilation -XX:TieredStopAtLevel=1 #{java_options}"
        )
      end
    end
  end
end
