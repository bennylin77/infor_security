class ModifyJobDetails < ActiveRecord::Migration
  def change
    remove_column :job_details, :serverity
    remove_column :job_details, :region
    remove_column :job_details, :action
       add_column :job_details, :alert, :boolean
  end
end
