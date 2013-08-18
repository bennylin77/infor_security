class AddAlwaysHandleToJobsAndIpMaps < ActiveRecord::Migration
  def change
    add_column :jobs, :always_handle, :boolean, :default => true, :null => false
    add_column :ip_maps, :always_handle, :boolean, :default => true, :null => false
  end
end
