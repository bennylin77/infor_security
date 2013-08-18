class AddCommentTopToPermissionConfig < ActiveRecord::Migration
  def change
	add_column :permission_configs, :comment_top, :int,  :default => false     #for 換工程師時寫reason
  end
end
