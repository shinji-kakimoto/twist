require 'rails_helper'

describe Account do
  def schema_exists?(account)
    query = %Q{SELECT nspname FROM pg_namespace
               WHERE nspname='#{account.subdomain}'}
    result = ActiveRecord::Base.connection.select_value(query)
    result.present?
  end

  it "creates a schema" do
    account = Account.create!({
      :name      => "First Account",
      :subdomain => "first",
    })
    # TODO: 実行する度にSchemaが残っている
    account.create_schema
    failure_message = "Schema #{account.subdomain} does not exists"
    assert schema_exists?(account), failure_message
  end
end
