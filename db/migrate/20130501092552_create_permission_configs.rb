class CreatePermissionConfigs < ActiveRecord::Migration
  def change
    create_table :permission_configs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.integer :adm_user_id
      t.integer :account, :default => 0, :null => false
      t.integer :ip, :default => 0, :null => false
      t.integer :event, :default => 0, :null => false
      t.integer :building, :default => 0, :null => false
      t.integer :job, :default => 0, :null => false

      t.timestamps
    end
  end
end
