class AddColJoblogCountry < ActiveRecord::Migration
  def change
    add_column :job_logs ,:country ,:string 
  end
end
