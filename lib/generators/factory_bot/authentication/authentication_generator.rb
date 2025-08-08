# frozen_string_literal: true

require "generators/factory_bot"
require "factory_bot_rails"
require "fileutils"

module FactoryBot
  module Generators
    class AuthenticationGenerator < Base
      def create_users_factory
        dir = factories_dir
        FileUtils.mkdir_p(dir)

        target = File.join(dir, "users.rb")
        if File.exist?(target)
          say_status :skip, "users.rb already exists at #{target}", :yellow
        else
          template "users.rb", target
          say_status :create, target, :green
        end
      end

      private

      def factories_dir
        if Dir.exist?(Rails.root.join("spec"))
          Rails.root.join("spec", "factories").to_s
        else
          Rails.root.join("test", "factories").to_s
        end
      end
    end
  end
end
