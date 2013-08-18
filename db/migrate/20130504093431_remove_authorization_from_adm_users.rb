class RemoveAuthorizationFromAdmUsers < ActiveRecord::Migration
  def change
    remove_column :adm_users, :authorization
  end
end
