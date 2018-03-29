require 'factory_bot'
require 'factory_bot_rails/generator'
require 'rails'

module FactoryBot
  class Railtie < Rails::Railtie
    ORMS_USING_LOAD_HOOKS = {
      "Mongoid" => :mongoid,
      "SequelRails" => :sequel,
      "MongoMapper" => :mongo_mapper,
      "ActiveRecord" => :active_record,
      # datamapper doesn't seem to use load hooks...
    }.freeze

    initializer "factory_bot.set_fixture_replacement" do
      FactoryBotRails::Generator.new(config).run
    end

    initializer "factory_bot.set_factory_paths" do
      FactoryBot.definition_file_paths = [
        Rails.root.join('factories'),
        Rails.root.join('test', 'factories'),
        Rails.root.join('spec', 'factories')
      ]
    end

    config.after_initialize do
      find_definitions_after_orm_load

      if defined?(Spring)
        Spring.after_fork { FactoryBot.reload }
      end
    end

    def self.find_definitions_after_orm_load
      return FactoryBot.find_definitions unless hook_name = orm_load_hook_name
      ActiveSupport.on_load(hook_name) { FactoryBot.find_definitions }
    end

    def self.orm_load_hook_name
      ORMS_USING_LOAD_HOOKS.each do |orm_module_name, hook_name|
        return hook_name if orm_module_name.safe_constantize
      end
    end
  end
end
