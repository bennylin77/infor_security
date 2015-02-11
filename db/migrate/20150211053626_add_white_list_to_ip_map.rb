class AddWhiteListToIpMap < ActiveRecord::Migration
  def change
    add_column :ip_maps, :white_list, :boolean,:default => 1
  end
end
