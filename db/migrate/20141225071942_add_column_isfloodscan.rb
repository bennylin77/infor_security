class AddColumnIsfloodscan < ActiveRecord::Migration
  def change
	add_column :job_details, :isflood_scan, :integer, :default=>0
  end
end
