class AddColJoblogThreatType < ActiveRecord::Migration
  def change
    add_column :job_logs , :threat_type , :string
  end
end
