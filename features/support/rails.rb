# frozen_string_literal: true

# Much here borrowed from
# https://github.com/cucumber/cucumber-rails/blob/f2b77091a614874bea21fc2a0a29913f7882bc96/features/support/cucumber_rails_helper.rb
module RailsHelper
  def rails_new(name)
    validate_rails_new_success(run_rails_new_command(name))
  end

  def install_gems
    add_conditional_gems
    run_command_and_stop "bundle install"
    run_command_and_stop "bundle exec rails webpacker:install" if rails6?
  end

  private

  def run_rails_new_command(name)
    run_command "bundle exec rails new #{name} --skip-bundle --skip-bootsnap}"
  end

  def validate_rails_new_success(result)
    expect(result).to have_output(/README/)
    expect(last_command_started).to be_successfully_executed
  end

  def rails6?
    `bundle exec rails -v`.start_with?("Rails 6")
  end

  def add_conditional_gems
    if rails6?
      add_gem "sqlite3", "~> 1.4"
    else
      add_gem "sqlite3", "~> 1.3.6"
    end
  end

  def add_gem(name, *args)
    line = convert_gem_opts_to_string(name, *args)
    gem_regexp = /gem [""]#{name}[""].*$/
    gemfile_content = File.read(expand_path("Gemfile"))

    if gemfile_content =~ gem_regexp
      updated_gemfile_content = gemfile_content.gsub(gem_regexp, line)
      overwrite_file("Gemfile", updated_gemfile_content)
    else
      append_to_file("Gemfile", line)
    end
  end

  def convert_gem_opts_to_string(name, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    parts = ["'#{name}'"]
    parts << args.map(&:inspect) if args.any?
    parts << options.inspect[1..-2] if options.any?
    new_parts = parts.flatten.map { |part| part.gsub(/:(\w+)=>/, '\1: ') }
    "gem #{new_parts.join(', ')}\n"
  end
end

World(RailsHelper)
