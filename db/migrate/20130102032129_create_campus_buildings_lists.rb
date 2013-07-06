class CreateCampusBuildingsLists < ActiveRecord::Migration
  def change
    create_table :campus_buildings_lists, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :campus_name
      t.string :building_name

      t.timestamps
    end
  end
end
