class RemoveFillInAdmUserIdFromIpMaps < ActiveRecord::Migration
  def change
    remove_column :ip_maps, :fill_in_adm_user_id  
  end
end
