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
    end
  end
end
