class RemoveThreatIdFromJobDetails < ActiveRecord::Migration
  def change
    remove_column :job_details, :threat_id
  end
end
