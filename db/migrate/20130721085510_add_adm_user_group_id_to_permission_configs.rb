class AddAdmUserGroupIdToPermissionConfigs < ActiveRecord::Migration
  def change
    add_column :permission_configs, :adm_user_group_id, :integer    
  end
end
