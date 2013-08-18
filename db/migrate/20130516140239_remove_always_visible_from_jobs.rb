class RemoveAlwaysVisibleFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :always_visible
  end
end
