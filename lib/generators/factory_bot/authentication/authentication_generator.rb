require "generators/factory_bot"
require "factory_bot_rails"

module FactoryBot
  module Generators
    class AuthenticationGenerator < Base
      def create_fixture_file
        template "users.rb", "test/factories/users.rb"
      end
    end
  end
end
