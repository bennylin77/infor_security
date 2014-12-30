class CreateTableFireeyeLogs < ActiveRecord::Migration
  def change
  	create_table :fireeye_logs, :options => 'ENGINE=MyISAM DEFAULT CHARSET=utf8' do |t|
      t.string :event_level
      t.integer :event_id
#      t.string :event_source
      t.string :malware_name
      t.string :src_ip
      t.string :dst_ip
      t.datetime :log_time
      
      t.timestamps
    end
  end
end
