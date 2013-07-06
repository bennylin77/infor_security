class CreateEventMaps < ActiveRecord::Migration
  def change
    create_table :event_maps, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.text :thread_id
      t.text :name
      t.text :chinese_name      
      t.text :description
      t.text :chinese_description
      t.text :suggestion
      t.string :cve_id
      t.string :category
      t.string :severity
      t.string :reference
      
      t.timestamps
    end
  end
end
