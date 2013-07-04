class RemoveCommentTop < ActiveRecord::Migration
  def change
	remove_column :permission_configs, :comment_top
  end
end
