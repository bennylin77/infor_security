class AddLasTodayCount < ActiveRecord::Migration
  def change
		add_column :job_details, :today_count, :integer, :default=>0 
		add_column :job_details, :last_count, :integer, :default=>0
  end
end
