class AddChangeReasonToComments < ActiveRecord::Migration
  def change
	add_column :comments, :change_note, :text     #for 換工程師時寫reason
  end
end
