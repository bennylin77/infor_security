class JobsAlwaysvisiable < ActiveRecord::Migration
  def change
	   add_column :jobs, :always_visible, :boolean, :default=>false, :null=>false
  end
end
