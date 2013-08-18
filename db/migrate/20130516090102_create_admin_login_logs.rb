class CreateAdminLoginLogs < ActiveRecord::Migration
  def change
    create_table :admin_login_logs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.integer :adm_user_id 
      t.datetime :login_at
      t.timestamps
    end
  end
end
