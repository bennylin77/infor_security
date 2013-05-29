class AddAlwaysVisibleToIpMaps < ActiveRecord::Migration
  def change
    add_column :ip_maps, :always_visible, :boolean, :default => false, :null => false
  end
end
