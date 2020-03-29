# frozen_string_literal: true

# Much here borrowed from the rails helper on
# https://github.com/cucumber/cucumber-rails
module RailsHelper
  def rails_new(name)
    validate_rails_new_success(run_rails_new_command(name))
  end

  def install_gems
    # NOTE: this addresses https://github.com/rails/rails/issues/35161
    add_gem "sqlite3", "~> 1.3.6" unless rails6?
    run_command_and_stop "bundle install"
  end

  private

  def run_rails_new_command(name)
    options = "--skip-bundle --skip-bootsnap --skip-javascript"
    run_command "bundle exec rails new #{name} #{options}"
  end

  def validate_rails_new_success(result)
    expect(result).to have_output(/README/)
    expect(last_command_started).to be_successfully_executed
  end

  def rails6?
    `bundle exec rails -v`.start_with?("Rails 6")
  end

  def add_gem(name, *args)
    line = convert_gem_opts_to_string(name, *args)
    gem_regexp = /gem '#{name}'.*$/
    gemfile_content = File.read(expand_path("Gemfile"))

    if gemfile_content =~ gem_regexp
      updated_gemfile_content = gemfile_content.gsub(gem_regexp, line)
      overwrite_file("Gemfile", updated_gemfile_content)
    else
      append_to_file("Gemfile", line)
    end
  end

  def convert_gem_opts_to_string(*args)
    gem_args = args.map(&:inspect).join(", ")
    "gem #{gem_args}\n"
  end
end

World(RailsHelper)
