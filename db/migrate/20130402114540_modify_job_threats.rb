class ModifyJobThreats < ActiveRecord::Migration
  def change
    add_column :job_threats, :serverity, :string 
  end
end
