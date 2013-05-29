class CreateJobLogs < ActiveRecord::Migration
  def change
    create_table :job_logs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :job_id
      t.datetime :log_time
      t.string :victim_ip
      t.timestamps
    end
  end
end
