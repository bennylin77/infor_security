class AddCommentToPermissionConfigs < ActiveRecord::Migration
  def change
    add_column :permission_configs, :comment, :integer, :default => 0, :null => false    
  end
end
