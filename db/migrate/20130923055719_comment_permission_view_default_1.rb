class CommentPermissionViewDefault1 < ActiveRecord::Migration
  def change
	change_column :permission_configs , :comment , :integer , :default=>1
  end
end
