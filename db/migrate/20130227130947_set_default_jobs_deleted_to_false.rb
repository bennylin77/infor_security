class SetDefaultJobsDeletedToFalse < ActiveRecord::Migration
  def change
    change_column :jobs, :deleted, :boolean, :default => false, :null => false
  end
end
