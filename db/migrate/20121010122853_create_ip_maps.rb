class CreateIpMaps < ActiveRecord::Migration
  def change
    create_table :ip_maps, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :fill_in_adm_user_id
      t.string  :ip
      t.integer :IPv4_1
      t.integer :IPv4_2
      t.integer :IPv4_3
      t.integer :IPv4_4            
      t.integer :adm_user_id
      t.string :OS
      t.string :OS_others
      t.string :version 
      t.string :place
      t.string :place_others
      t.string :use
      t.string :use_others
      t.string :user
      t.integer :campus_buildings_list_id
      t.string :room
      t.integer :extend   
      t.timestamps
    end
  end
end
