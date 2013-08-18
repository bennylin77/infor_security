class AddCloseDirectlyReasonToSCloseds < ActiveRecord::Migration
  def change
    add_column :s_closeds, :close_directly_reason, :text    
  end
end
