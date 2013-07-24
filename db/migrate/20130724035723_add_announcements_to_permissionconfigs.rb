class AddAnnouncementsToPermissionconfigs < ActiveRecord::Migration
  def change
  add_column :permission_configs, :announcement, :integer, :default => 0, :null => false
  end
end
