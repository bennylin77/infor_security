class ModifyJobLogs < ActiveRecord::Migration
  def change
    add_column :job_logs, :region, :string
    add_column :job_logs, :action, :string
  end
end
