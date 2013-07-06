class AddBlockToIpMaps < ActiveRecord::Migration
  def change
    add_column :ip_maps, :block, :boolean, :default => false, :null => false
  end
end
