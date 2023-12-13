# frozen_string_literal: true

describe FactoryBotRails::FactoryValidator do
  before { FactoryBot.reload }

  describe "ActiveRecordValidator" do
    context "when defined with a class that descends from ActiveRecord::Base" do
      it "raises an error for a sequence generating its primary key" do
        define_model "Article", an_id: :integer do
          self.primary_key = :an_id
        end

        FactoryBot.define do
          factory :article do
            sequence(:an_id)
          end
        end

        expect { FactoryBot.create(:article) }
          .to raise_error(FactoryBot::AttributeDefinitionError)
      end


      context "when factory is configured to allow primary key definitions" do
        # NOTE: Modifying Factory here is only a proof of concept
        class FactoryBot::Factory
          attr_reader :options

          def initialize(name, options = {})
            assert_valid_options(options)
            @name = name.respond_to?(:to_sym) ? name.to_sym : name.to_s.underscore.to_sym
            @parent = options[:parent]
            @aliases = options[:aliases] || []
            @class_name = options[:class]
            @definition = FactoryBot::Definition.new(@name, options[:traits] || [])
            @compiled = false

            @options = options # <-- Addition
          end

          def assert_valid_options(options)
            options.assert_valid_keys(:class, :parent, :aliases, :traits, :config)
          end
        end

        it "does not raise an error for a sequence generating its primary key" do
          define_model "Warehouse", an_id: :integer do
            self.primary_key = :an_id
          end

          FactoryBot.define do
            factory :warehouse, config: { allow_primary_key_definitions: true } do
              sequence(:an_id)
            end
          end

          expect { FactoryBot.create(:warehouse) }.not_to raise_error
        end
      end
    end
  end
end
