class AddAdmUserIdToMailConfigs < ActiveRecord::Migration
  def change
    add_column :mail_configs, :adm_user_id, :integer    
  end
end
