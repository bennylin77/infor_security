class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :handling_adm_user_id, :integer    
    add_column :comments, :assigning_adm_user_id, :integer   
    add_column :comments, :stage, :string  
    add_column :comments, :report, :text        
  end
end
