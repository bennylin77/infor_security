class AddIndexToOutsideLogs < ActiveRecord::Migration
  def change
  add_index :outside_logs, :victim_ip
  add_index :outside_logs, :threat_id
  add_index :outside_logs, :log_time
  add_index :outside_logs, :outside_counts_id
  end
end
