# frozen_string_literal: true

ActiveStorage::Engine.root.glob("db/migrate/*.rb").each { |file| require file }

ActiveSupport.on_load :active_support_test_case do
  setup do
    CreateActiveStorageTables.migrate :up
  end

  teardown do
    CreateActiveStorageTables.migrate :down
  rescue ActiveRecord::StatementInvalid
    # no-op
  end
end

defined?(RSpec) && RSpec.configure do |config|
  config.before do
    CreateActiveStorageTables.migrate :up
  end

  config.after do
    CreateActiveStorageTables.migrate :down
  rescue ActiveRecord::StatementInvalid
    # no-op
  end
end
