class AddDoneAtToStage < ActiveRecord::Migration
  def change
    add_column :s_assigns, :done_at, :datetime
    add_column :s_checks, :done_at, :datetime
    add_column :s_closeds, :done_at, :datetime
    add_column :s_handles, :done_at, :datetime            
    add_column :s_informs, :done_at, :datetime     
  end
end
