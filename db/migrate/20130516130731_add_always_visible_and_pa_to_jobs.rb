class AddAlwaysVisibleAndPaToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :always_visible, :boolean, :default => false, :null => false
    add_column :jobs, :PA, :boolean, :default => true, :null => false    
  end
end
