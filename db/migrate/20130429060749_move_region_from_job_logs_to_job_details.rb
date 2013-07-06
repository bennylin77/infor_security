class MoveRegionFromJobLogsToJobDetails < ActiveRecord::Migration
  def change
    remove_column :job_logs, :region
    add_column    :job_details, :region, :string   
  end
end
