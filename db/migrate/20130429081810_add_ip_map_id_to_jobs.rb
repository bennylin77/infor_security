class AddIpMapIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :ip_map_id, :integer    
  end
end
