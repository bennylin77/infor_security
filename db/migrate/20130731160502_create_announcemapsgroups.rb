class CreateAnnouncemapsgroups < ActiveRecord::Migration
  def change
    create_table :announcemapsgroups do |t|
      t.integer :announcement_id
      t.integer :adm_group_id

      t.timestamps
    end
  end
end
