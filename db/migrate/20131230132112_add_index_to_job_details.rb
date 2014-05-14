class AddIndexToJobDetails < ActiveRecord::Migration
  def change
  add_index :job_details, :job_id
  end
end
