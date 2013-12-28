class AddLogDate < ActiveRecord::Migration
  def change
    add_column :outside_counts , :log_date , :date
    add_column :job_logs , :src_ip , :string
  end
end
