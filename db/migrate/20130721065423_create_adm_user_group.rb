class CreateAdmUserGroup < ActiveRecord::Migration

  def change
    create_table :adm_user_groups, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.string  :name
      t.integer :account, :default => 0, :null => false
      t.integer :ip, :default => 0, :null => false
      t.integer :event, :default => 0, :null => false
      t.integer :building, :default => 0, :null => false
      t.integer :job, :default => 0, :null => false     
      t.integer :comment, :default => 0, :null => false

      t.timestamps
    end
  end
end
