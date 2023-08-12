module FactoryBotRails
  class FactoryValidator
    def initialize(validators = [])
      @validators = Array(validators)
    end

    def add_validator(validator)
      @validators << validator
    end

    def run
      ActiveSupport::Notifications.subscribe("factory_bot.compile_factory", &validate_compiled_factory)
    end

    private

    def validate_compiled_factory
      if Rails.version >= "6.0"
        rails_6_0_support
      else
        rails_5_2_support
      end
    end

    def rails_6_0_support
      proc do |event|
        @validators.each { |validator| validator.validate!(event.payload) }
      end
    end

    def rails_5_2_support
      proc do |*notification_event_arguments|
        event = ActiveSupport::Notifications::Event.new(*notification_event_arguments)

        rails_6_0_support.call(event)
      end
    end
  end
end
