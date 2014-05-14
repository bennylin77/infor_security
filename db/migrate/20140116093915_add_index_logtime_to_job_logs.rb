class AddIndexLogtimeToJobLogs < ActiveRecord::Migration
  def change
  add_index :job_logs, :log_time
  add_index :job_logs, :threat_id 
  add_index :job_logs, :victim_ip
  end
end
