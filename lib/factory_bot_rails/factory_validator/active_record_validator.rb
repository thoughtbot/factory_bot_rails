module FactoryBotRails
  class FactoryValidator
    class ActiveRecordValidator
      def validate!(payload)
        attributes, for_class, factory_name = payload.values_at(:attributes, :class, :name)

        return if !(for_class && for_class < ActiveRecord::Base)

        factory = FactoryBot::Internal.factory_by_name(factory_name)
        if (factory.options[:config] || {} )[:allow_primary_key_definitions] == true
          return
        end

        attributes.each do |attribute|
          if for_class.primary_key == attribute.name.to_s
            raise FactoryBot::AttributeDefinitionError, <<~ERROR
              Attribute generates #{for_class.primary_key.inspect} primary key for #{for_class.name}"

              Do not define #{for_class.primary_key.inspect}. Instead, rely on the database to generate it.
            ERROR
          end
        end
      end
    end
  end
end
