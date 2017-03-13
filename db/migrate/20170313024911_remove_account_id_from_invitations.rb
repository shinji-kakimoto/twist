class RemoveAccountIdFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :account_id
  end
end
