class CreateEventAdmLogs < ActiveRecord::Migration
  def change
    create_table :event_adm_logs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.integer :adm_user_id 
      t.datetime :edit_at
      t.timestamps
    end
  end
end
