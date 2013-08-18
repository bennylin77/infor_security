class AddThreatIdToJobLogs < ActiveRecord::Migration
  def change
    add_column :job_logs, :threat_id, :integer
  end
end
