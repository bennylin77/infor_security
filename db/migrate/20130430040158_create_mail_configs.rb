class CreateMailConfigs < ActiveRecord::Migration
  def change
    create_table :mail_configs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.boolean :meeting_notification, :default => false, :null => false
      t.boolean :weekly_statistic, :default => false, :null => false

      t.timestamps
    end
  end
end
