class CreateTraceConfigs < ActiveRecord::Migration
  def change
    create_table :trace_configs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|

      t.integer :adm_user_id      
      t.boolean :login, :default => false, :null => false
      t.boolean :event_log, :default => false, :null => false      
      t.boolean :assign, :default => false, :null => false      
      t.boolean :closed, :default => false, :null => false         
      
      t.timestamps
    end
 
  end
end
