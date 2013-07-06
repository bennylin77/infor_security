class AddNoteAtComments < ActiveRecord::Migration
  def change
		add_column :comments, :adm_note, :text     #for assigned_user 退件時寫reason
		add_column :comments, :handle_note, :text  #for handle_user 處理時log
  end
end
